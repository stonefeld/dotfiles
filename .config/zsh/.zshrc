#          _
#  _______| |__
# |_  / __| '_ \
#  / /\__ \ | | |
# /___|___/_| |_|

[[ $- != *i* ]] && return

# ---------- PROMPT ---------- #
# Required line to automatically update the prompt.
setopt prompt_subst

# Load advanced completion system.
autoload -U compinit
compinit -d $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION
zstyle ':completion:*' menu select cache-path $XDG_CACHE_HOME/zsh/zcompcache

# Small function to detect an active virtual environment and return the name.
# Avoid creating virtual environments with dashes inside the name.
virtualenv_info() { [ -n "$VIRTUAL_ENV" ] && echo "%B%F{yellow}($(cut -d '-' -f 1 <<< ${VIRTUAL_ENV##*/}))%f%b" 2>/dev/null }

# Small function to detect if the directory is a git repository and change
# prompt's current working directory length to 1.
gitdir() { git check-ignore -q . 2>/dev/null; [ "$?" -eq "1" ] && echo 1 || echo 3 }

# Setting up the normal prompt.
if [ "$COLORSCHEME" = "nord" ]; then
    PROMPT='%B%F{blue}[%f%F{cyan}%n%f%F{blue}@%f%F{cyan}%m%f %F{yellow}%$(gitdir)~%f%F{blue}]%f%b%F{white} '
else
    PROMPT='%B%F{red}[%f%F{yellow}%n%f%F{green}@%f%F{blue}%m%f %F{magenta}%$(gitdir)~%f%F{red}]%f%b%F{white} '
fi

# The right prompt displays the virtual environment's name.
RPROMPT='$(virtualenv_info)'

# ---------- ALIASES ---------- #
# System power.
alias sn="shutdown now"
alias re="reboot"
alias ss="systemctl suspend"

# Pacman shortcuts.
alias pacinstall="pacman -Slq | fzf --height 0% --multi --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S"
alias pacremove="pacman -Qq | fzf --height 0% --multi --preview 'pacman -Qi {1}' | xargs -ro sudo pacman -Rns"
alias pacupdate="sudo pacman -Syy && sudo pacman -Su --noconfirm && echo 0 > ${XDG_DATA_HOME:-$HOME/.local/share}/updates && status-init"

# Quickly move to another directory.
alias md='cd "$(find ~ -maxdepth 5 -type d | sed "/\.git/d;/\.venv/d;/node_modules/d;/virtualenv*/d" | fzf)"'

# Some ls command replacements.
if ! command -v exa &>/dev/null; then
    alias ls="ls -h --color=always --group-directories-first"
else
    alias ls="exa -g --color=always --group-directories-first"
fi
alias lf="vifm ."

# Avoid overriding.
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# Pass aliases to sudo.
alias sudo='sudo '

# Neovim shortcuts.
alias e="$EDITOR"
alias e.="$EDITOR ."
alias ef="fzf --preview 'cat {}'| xargs -ro $EDITOR"

# Python and pip shortcuts
alias py='python3'
alias pe='pipenv'
alias pyenvinit='eval "$(pyenv init -)"'
alias pip3update="sudo pip3 list --outdated | awk '{print $1}' | tail -n+3 | xargs -r -n1 sudo pip3 install --upgrade"
alias pepyls='pipenv install --dev python-language-server rope pyflakes mccabe pycodestyle pydocstyle autopep8 yapf'
alias pippyls='pip install python-language-server rope pyflakes mccabe pycodestyle pydocstyle autopep8 yapf'

# Show all manpages on a fzf table and select the one to read.
alias mans='man -k . | fzf | sed "s/ \+/ /g" | cut -d " " -f 1 | xargs -r man'

# Lazygit shortctut.
alias lgit='lazygit'

# Open irssi and specify the config and data folder.
alias irssi='irssi --config="$XDG_CONFIG_HOME"/irssi/config --home="$XDG_DATA_HOME"/irssi'

# Getting colored outputs.
alias ip='ip -color=auto'
alias diff='diff --color=auto'
alias dmesg='dmesg --color=always'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# System shortcuts.
alias sys='systemctl'
alias jou='journalctl'

# Monkiflip.
alias monkiflip='mpv "https://www.youtube.com/watch?v=XZ5Uv4JKTU4"'

# Manage dotfiles.
alias dotfiles='/usr/bin/git --git-dir=$HOME/.local/share/dotfiles --work-tree=$HOME'

# ---------- KEYBINDINGS ---------- #
bindkey '^P' up-line-or-history      # Ctrl+p
bindkey '^N' down-line-or-history    # Ctrl+n
bindkey '^[[A' up-line-or-history    # Up arrow
bindkey '^[[B' down-line-or-history  # Down arrow
bindkey '^[[D' backward-char         # Left arrow
bindkey '^[[C' forward-char          # Right arrow
bindkey '^[[1;5D' backward-word      # Ctrl+Left arrow
bindkey '^[[1;5C' forward-word       # Ctrl+Right arrow
bindkey '^[[H' beginning-of-line     # Home
bindkey '^[[4~' end-of-line          # End
bindkey '^[[4h' overwrite-mode       # Insert
bindkey '^[[P' delete-char           # Delete
bindkey '^[[Z' reverse-menu-complete # Shift+Tab

# ---------- VI MODE ---------- #
# Activate vi mode.
bindkey -v

# Remove mode switching delay.
KEYTIMEOUT=5

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd)      echo -ne '\e[1 q';;
        viins|main) echo -ne '\e[5 q';;
    esac
}
zle -N zle-keymap-select

# Use beam shape cursor on startup.
echo -ne '\e[5 q'

# Use beam shape for each new prompt.
fix_cursor() {
    echo -ne '\e[5 q'
}
precmd_functions+=(fix_cursor)

# ---------- TITLE ---------- #
# Print the username, the hostname and the path.
function set_title () {
    print -Pn -- '\e]2;%n@%m %~\a'
}

# Rewrite the title for each new prompt.
precmd_functions+=(set_title)

# ---------- EXTRAS ---------- #
# Get syntax highlighting while writiing.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
