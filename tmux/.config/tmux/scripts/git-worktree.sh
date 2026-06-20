#!/usr/bin/env bash
# Pick a git worktree to open, or type a new name to create one, via fzf.
# Meant to be run inside a tmux display-popup.
#
# - Existing worktrees are listed; selecting one opens it in a new window.
# - Typing a name with no match creates <parent-of-repo>/<repo>-<name> on a
#   branch named <name> (reusing the branch if it already exists), so every
#   worktree sits at the same directory level as the main checkout.
#
# Usage: git-worktree.sh [pane_current_path]

set -euo pipefail

pane_path="${1:-$PWD}"

if ! command -v fzf >/dev/null 2>&1; then
	tmux display-message "worktree: fzf is not installed"
	exit 0
fi

# Resolve the main repository root (works even from inside a worktree).
toplevel="$(git -C "$pane_path" rev-parse --show-toplevel 2>/dev/null || true)"
if [ -z "$toplevel" ]; then
	tmux display-message "worktree: not inside a git repository"
	exit 0
fi

common_dir="$(git -C "$toplevel" rev-parse --path-format=absolute --git-common-dir 2>/dev/null || echo "$toplevel/.git")"
repo_root="$(dirname "$common_dir")"
parent="$(dirname "$repo_root")"

# Build "<branch>\t<path>" rows for every existing worktree.
list_worktrees() {
	git -C "$repo_root" worktree list --porcelain | awk '
		/^worktree /  { path = substr($0, 10) }
		/^branch /    { b = $2; sub("refs/heads/", "", b); printf "%s\t%s\n", b, path; path = "" }
		/^detached$/  { printf "%s\t%s\n", "(detached)", path; path = "" }
		/^bare$/      { printf "%s\t%s\n", "(bare)", path; path = "" }
	'
}

open_window() {
	local path="$1" name="$2"
	tmux new-window -c "$path"
	tmux rename-window "$name"
}

selection="$(list_worktrees | fzf \
	--print-query \
	--expect=ctrl-x \
	--delimiter='\t' \
	--with-nth=1,2 \
	--prompt='worktree> ' \
	--header='enter: open/create · ctrl-x: delete selected' \
	|| true)"

[ -z "$selection" ] && exit 0

# With --print-query + --expect, output is: query, pressed-key, selection.
query="$(printf '%s\n' "$selection" | sed -n 1p)"
key="$(printf '%s\n' "$selection" | sed -n 2p)"
choice="$(printf '%s\n' "$selection" | sed -n 3p)"

# ctrl-x on an existing worktree -> remove it (after confirmation).
if [ "$key" = "ctrl-x" ]; then
	[ -z "$choice" ] && exit 0
	path="$(printf '%s' "$choice" | cut -f2)"
	name="$(printf '%s' "$choice" | cut -f1)"
	if [ "$path" = "$repo_root" ]; then
		tmux display-message "worktree: refusing to remove the main worktree"
		exit 0
	fi
	printf 'remove worktree "%s" at %s? [y/N] ' "$name" "$path"
	read -r confirm || true
	case "$confirm" in
		[yY]*)
			if err="$(git -C "$repo_root" worktree remove "$path" 2>&1)"; then
				tmux display-message "worktree: removed $name"
			else
				tmux display-message "worktree: ${err:-failed to remove $name}"
			fi
			;;
	esac
	exit 0
fi

# An existing worktree was selected -> just open it.
if [ -n "$choice" ]; then
	path="$(printf '%s' "$choice" | cut -f2)"
	name="$(printf '%s' "$choice" | cut -f1)"
	[ "$name" = "(detached)" ] || [ "$name" = "(bare)" ] && name="$(basename "$path")"
	open_window "$path" "$name"
	exit 0
fi

# No match selected -> create a new worktree from the typed query.
name="$query"
[ -z "$name" ] && exit 0

# Slashes can't be a single directory component, so flatten them for the path
# only -- the branch and window keep the exact name.
dir_name="${name//\//-}"
worktree_path="$parent/$dir_name"

if [ ! -d "$worktree_path" ]; then
	if git -C "$repo_root" show-ref --verify --quiet "refs/heads/$name"; then
		git -C "$repo_root" worktree add "$worktree_path" "$name" \
			|| { tmux display-message "worktree: failed to add '$name'"; exit 0; }
	else
		git -C "$repo_root" worktree add -b "$name" "$worktree_path" \
			|| { tmux display-message "worktree: failed to create '$name'"; exit 0; }
	fi
fi

open_window "$worktree_path" "$name"
