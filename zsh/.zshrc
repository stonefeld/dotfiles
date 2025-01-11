# Set the zinit directory
ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"

# Clone the zinit repository
if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname "$ZINIT_HOME")"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Change zcompdump location
ZSH_COMPDUMP="${XDG_CACHE_HOME:-$HOME/.cache}/zcompdump-${(%):-%m}-${ZSH_VERSION}"

# Source the zinit script
source "$ZINIT_HOME/zinit.zsh"

# Add omz libraries
zinit snippet OMZL::functions.zsh
zinit snippet OMZL::async_prompt.zsh
zinit snippet OMZL::key-bindings.zsh
zinit snippet OMZL::termsupport.zsh
zinit snippet OMZL::git.zsh

# Add omz plugins
zinit snippet OMZP::archlinux
zinit snippet OMZP::systemd
zinit snippet OMZP::git
zinit snippet OMZP::gitignore
zinit snippet OMZP::python

# Setting the prompt
setopt prompt_subst
zinit snippet OMZT::robbyrussell

# Add big 3 zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

# FZF integration
zinit light Aloxaf/fzf-tab

# Load completions
autoload -U compinit && compinit -d $ZSH_COMPDUMP
zinit cdreplay -q

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# History configuration
HISTSIZE=5000
HISTFILE=~/.cache/zsh_history
SAVEHIST=$HISTSIZE
setopt hist_expire_dups_first       # expire duplicate event first when trimming history
setopt hist_find_no_dups            # do not display a duplicate event if it is already in the history
setopt hist_ignore_all_dups         # delete old recorded event if new event is a duplicate
setopt hist_ignore_dups             # do not save events that are duplicates of previous events
setopt hist_ignore_space            # ignore lines which begin with a space
setopt hist_save_no_dups            # do not write a duplicate event to history
setopt share_history                # share history between all sessions

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# Shell integrations
command -v zoxide &>/dev/null && eval "$(zoxide init zsh)"
command -v pyenv &>/dev/null && eval "$(pyenv init -)"
command -v fzf &>/dev/null && eval "$(fzf --zsh)"

# Aliases
if command -v eza &>/dev/null; then
    alias ls='eza --group-directories-first -g'
    alias la='ls -a'
    alias ll='la -la'
else
    alias ls='LC_COLLATE=C ls --group-directories-first'
    alias la='ls -a'
    alias ll='la -lh'
fi

alias ip='ip -c'

alias lg='lazygit'

alias v='nvim'
alias vv="[ -f 'Session.vim' ] && nvim -S Session.vim || nvim -c 'Obsession'"
alias v.="nvim ."

alias tmuxd='tmux new -s "${${PWD##*/}:-/}"'

alias pys='source .venv/bin/activate'
alias pyd='deactivate'

if command -v vifmrun &>/dev/null; then
    alias lf='vifmrun'
else
    alias lf='vifm'
fi

# Post init
[ -d "$PWD/.venv" ] && pys || :
