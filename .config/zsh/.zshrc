#            _
#    _______| |__  _ __ ___
#   |_  / __| '_ \| '__/ __|
#  _ / /\__ \ | | | | | (__
# (_)___|___/_| |_|_|  \___|

[[ $- != *i* ]] && return

# ---------- PROMPT ---------- #
# Required line to automatically update the prompt.
setopt prompt_subst

# Load advanced completion system.
autoload -U compinit
compinit -d ${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump-$ZSH_VERSION
zstyle ':completion:*' menu select cache-path ${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompcache-$ZSH_VERSION

# Save most recent 1000 lines on history file.
SAVEHIST=5000

# Get version control information to display on prompt.
autoload -Uz vcs_info
precmd_functions+=(vcs_info)
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '%F{black}-%F{blue}U'
zstyle ':vcs_info:*' stagedstr '%F{black}-%F{green}A'
zstyle ':vcs_info:git:*' formats '%F{yellow}%b%u%c'
zstyle ':vcs_info:git:*' actionformats '%F{yellow}%b%F{black}-%F{magenta}%a%F{black}-%F{red}%u%F{black}-%F{green}%c'

# Small function to detect an active virtual environment and return the name.
# Avoid creating virtual environments with dashes inside the name.
virtualenv_info() { [ -n "$VIRTUAL_ENV" ] && echo " %B%F{red}(%F{magenta}$(sed 's/\-[a-zA-Z0-9]*$//' <<< ${VIRTUAL_ENV##*/})%f%F{red})%f%b" 2>/dev/null; }

# Small function to detect if the directory is a git repository and change
# prompt's current working directory length to 1.
checkgitdir() { git check-ignore -q . 2>/dev/null; [ "$?" -eq '1' ] && return 0 || return 1 }
gitdir() { checkgitdir && echo "%1~" || echo "%3~"; }

# Display a smaller version of the pwd with only one letter for each parent dir.
pathshorten() { echo "$(pwd | sed -e "s|$HOME|~|" | sed -re "s|([^./])[^/]+/|\1/|g")"; }
gitpathshorten() { checkgitdir && echo "%1~" || pathshorten; }

# Display a '!' when the last command didn't exited succesfully.
last_status() { [ "$?" -ne 0 ] && echo "%B%F{red}(%f%F{yellow}!%f%F{red})%f%b"; }

# The right prompt displays the virtual environment's name.
RPROMPT='$(last_status)$(virtualenv_info)'

# defining multiple prompts.
default_prompt() { export PROMPT='%B%F{red}[%f%F{yellow}%n%f%F{green}@%f%F{blue}%m%f %F{magenta}$(gitdir)%f%F{red}]%f%b%F{white}$ '; }
default_prompt_short() { export PROMPT='%B%F{red}[%f%F{yellow}%n%f%F{green}@%f%F{blue}%m%f %F{magenta}$(gitpathshorten)%f%F{red}]%f%b%F{white}$ '; }
ultra_minimal_prompt() { export PROMPT='%B%F{cyan}%1~%f ${vcs_info_msg_0_}%F{red}:%f%b '; }
god_prompt() { export PROMPT='%B%F{black}╭─%F{red}(%f%F{yellow}%n%f%F{green}@%f%F{blue}%m%f%F{red})%F{black}-%f%F{red}(%f%F{magenta}$(gitdir)%f%F{red})%f'$'\n''%F{black}╰─%f%F{red}(%f${vcs_info_msg_0_}%F{red})%f$%b '; }
god_prompt_short() { export PROMPT=' %B%F{red}(%f%F{yellow}%n%f%F{green}@%f%F{blue}%m%f%F{red}) %F{red}(%f%F{magenta}$(gitpathshorten)%f%F{red})%f'$'\n'' %F{red}(%f${vcs_info_msg_0_}%F{red})%f$%b '; }
debian_prompt() { export PROMPT='%B%F{green}%n@%m%f%F{white}:%f%F{blue}%~%f%b%F{white}$ '; }
debian_prompt_short() { export PROMPT='%B%F{green}%n@%m%f%F{white}:%f%F{blue}$(pathshorten)%f%b%F{white}$ '; }
starship_prompt() { command -v starship &>/dev/null && source <(starship init zsh --print-full-init); }

# Setting up the normal prompt.
starship_prompt

# ---------- ALIASES ---------- #
# Pacman shortcuts.
alias pacinstall='pacman -Slq | fzf --height 0% --multi --preview "pacman -Si {1}" | xargs -ro sudo pacman -S'
alias pacremove='pacman -Qq | fzf --height 0% --multi --preview "pacman -Qi {1}" | xargs -ro sudo pacman -Rns'
alias pacupdate="sudo pacman -Syu --noconfirm && setsid -f pacupdatecheck"

# AUR helper shortcuts using fzf.
if command -v paru &>/dev/null; then
	alias parinstall='paru -Slq | fzf --height 0% --multi --preview "paru -Si {1}" | xargs -ro paru -S --noconfirm'
	alias parupdate="paru -Sua --noconfirm && setsid -f pacupdatecheck"
elif command -v yay &>/dev/null; then
	alias yayinstall='yay -Slq | fzf --height 0% --multi --preview "yay -Si {1}" | xargs -ro yay -S'
	alias yayupdate="yay -Sua --noconfirm && setsid -f pacupdatecheck"
fi

# Easily resource the zsh config file.
alias reso='source ${ZDOTDIR:-}/.zshrc'

# Some ls command replacements.
if command -v exa &>/dev/null; then
	alias ls='exa -g --color=always --group-directories-first'
	alias ll='exa -la -g --color=always --group-directories-first'
	alias la='exa -a -g --color=always --group-directories-first'
else
	alias ls='LC_COLLATE=C ls -hp --color=always --group-directories-first'
	alias ll='LC_COLLATE=C ls -lahp --color=always --group-directories-first'
	alias la='LC_COLLATE=C ls -ahp --color=always --group-directories-first'
fi
alias lf='$TERMFM .'

# Create a directory and cd into it
mkcd() {
	[ -z "$*" -o "$#" -gt 1 ] && echo "mkcd [DIR]" && return
	mkdir -p "$1"; cd "$1";
}

# Avoid overriding
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# Open any applications quicker
alias open='xdg-open'
if command -v neomutt &>/dev/null; then
	alias mutt='neomutt'
fi

# Clear the screen fr
alias cls='printf "\033c"'

# Pass aliases to sudo.
if command -v doas &>/dev/null; then
	alias doas='doas '
elif command -v sudo &>/dev/null; then
	alias sudo='sudo '
fi

# Python and pip shortcuts
alias py='python3'
alias pe='pipenv'
alias pyenvinit='eval "$(pyenv init -)"'

# Show all manpages on a fzf table and select the one to read.
alias mans='man -k . | fzf | sed "s/ \+/ /g" | cut -d " " -f 1 | xargs -r man'

# Lazygit shortctut.
alias lgit='lazygit'

# NetworkManager commands shortcuts.
alias wcon='nmcli device wifi connect'
alias wls='nmcli device wifi list'
alias wlsr='nmcli device wifi list --rescan yes'

# Getting colored outputs.
alias ip='ip -color=auto'
alias diff='diff --color=auto'
alias dmesg='dmesg --color=always'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# Faster mixer commands
alias pm='pulsemixer'
alias am='alsamixer'

# Manage bluetooth
alias bth='bluetoothctl'

# System shortcuts.
alias sys='systemctl'
alias jou='journalctl'

# Manage dotfiles.
alias dotfiles='/usr/bin/git --git-dir=$HOME/.local/share/dotfiles --work-tree=$HOME'

# Move quicker between folders with fzf.
move-cd() {
	cd "$(find ~ -maxdepth 5 -type d | sed "/\.git/d;/\.venv/d;/node_modules/d;/virtualenv*/d" | fzf)"
	zle reset-prompt &>/dev/null
}
zle -N move-cd

# ---------- KEYBINDINGS ---------- #
bindkey '^P' up-line-or-history      # Ctrl+p
bindkey '^N' down-line-or-history    # Ctrl+n
bindkey '^F' move-cd                 # Ctrl+f
bindkey '^[[1;5D' backward-word      # Ctrl+Left arrow
bindkey '^[[1;5C' forward-word       # Ctrl+Right arrow
bindkey '^?' backward-delete-char    # Backspace
bindkey '^H' backward-delete-char    # Ctrl+Backspace
bindkey '^[[H' beginning-of-line     # Home
bindkey '^[[4~' end-of-line          # End
bindkey '^[[4h' overwrite-mode       # Insert
bindkey '^[[P' delete-char           # Delete
bindkey '^[[M' delete-word           # Ctrl+Delete
bindkey '^[[Z' reverse-menu-complete # Shift+Tab
bindkey '^[[5~' beginning-of-history # PageUp
bindkey '^[[6~' end-of-history       # PageDown

# ---------- VI MODE ---------- #
# Activate vi mode.
bindkey -v

# Remove mode switching delay.
KEYTIMEOUT=5

# ---------- TITLE ---------- #
# Print the username, the hostname and the path.
function set_title() {
	print -Pn -- '\e]2;%n@%m:%~\a';
}

# Rewrite the title for each new prompt.
precmd_functions+=(set_title)

# ---------- PLUGINS ---------- #
# Syntax highlighting.
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

if [ -d /usr/share/zsh/plugins/zsh-syntax-highlighting ]; then
	source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
elif [ -d ${ZDOTDIR:-$HOME/.config/zsh}/zsh-syntax-highlighting ]; then
	source ${ZDOTDIR:-$HOME/.config/zsh}/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
fi

# Autosuggestions
if [ -d /usr/share/zsh/plugins/zsh-autosuggestions ]; then
	source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
	bindkey '^Y' autosuggest-accept
elif [ -d ${ZDOTDIR:-$HOME/.config/zsh}/zsh-autosuggestions ]; then
	source ${ZDOTDIR:-$HOME/.config/zsh}/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
	bindkey '^Y' autosuggest-accept
fi

# Gitflow completion
if [ -d ${ZDOTDIR:-$HOME/.config/zsh}/git-flow-completion ]; then
	source ${ZDOTDIR:-$HOME/.config/zsh}/git-flow-completion/git-flow-completion.zsh
fi

# FZF history search
if [ -d /usr/share/zsh/plugins/zsh-fzf-history-search ]; then
	source /usr/share/fzf/plugins/zsh-fzf-history-search/zsh-syntax-highlighting.plugin.zsh
elif [ -d ${ZDOTDIR:-$HOME/.config/zsh}/zsh-fzf-history-search ]; then
	source ${ZDOTDIR:-$HOME/.config/zsh}/zsh-fzf-history-search/zsh-fzf-history-search.plugin.zsh
fi
