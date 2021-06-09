#
# ~/.config/zsh/.zshrc
#

[[ $- != *i* ]] && return

# ---------- PROMPT ---------- #
# Required line to automatically update the prompt.
setopt prompt_subst

# Small function to detect an active virtual environment and return the name.
virtualenv_info() {
    if [[ -n "$VIRTUAL_ENV" ]]; then
        venv="$(cut -d "-" -f 1 <<< ${VIRTUAL_ENV##*/})"
    else
        venv=""
    fi
    [[ -n "$venv" ]] && echo "($venv)"
}

# Small function to detect if the directory is a git repository and change
# prompt's current working directory length to 1.
gitdir() { git check-ignore -q . 2>/dev/null; [ "$?" -eq "1" ] && echo 1 || echo 3 }

# Setting up the normal.
PROMPT='%B%F{red}[%f%F{yellow}%n%f%F{green}@%f%F{blue}%m%f %F{magenta}%$(gitdir)~%f%F{red}]%f%b%F{white} '

# The right prompt displays the virtual environment's name.
RPROMPT='%B%F{yellow}$(virtualenv_info)%f%b'

# ---------- ALIASES ---------- #
# System power.
alias sn="shutdown now"
alias re="reboot"
alias ss="systemctl suspend"

# Pacman shortcuts.
alias pacinstall="pacman -Slq | fzf --height 0% --multi --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S"
alias pacremove="pacman -Qq | fzf --height 0% --multi --preview 'pacman -Qi {1}' | xargs -ro sudo pacman -Rns"
alias pacupdate="sudo pacman -Syy && sudo pacman -Su --noconfirm && echo 0 > $XDG_DATA_HOME/updates && status-init"

# Some ls command replacements.
alias ls="ls -h --color=always --group-directories-first"
alias lf="vifm ."

# Avoid overriding.
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# Neovim shortcuts.
alias v='nvim'
alias v.='nvim .'
alias vf="fzf --preview 'cat {}'| xargs -ro nvim"

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

# Relevant folders shortcuts.
alias pro="cd ~/docs/projects/"
alias cod="cd ~/docs/code/"
alias rep="cd ~/docs/reports/"
alias pre="cd ~/docs/presentations/"
alias bin="cd ~/.local/bin/"

# Monkiflip.
alias monkiflip='mpv "https://www.youtube.com/watch?v=XZ5Uv4JKTU4"'

# ---------- KEYBINDINGS ---------- #
bindkey '^P' up-line-or-history
bindkey '^N' down-line-or-history

# ---------- FUNCTIONS ---------- #
# Some small functions to change the cursor style when changing from INSERT
# to NORMAL mode with vi keybdindings
function zle-keymap-select () {
    case $KEYMAP in
        vicmd)      echo -ne '\e[1 q';;
        viins|main) echo -ne '\e[5 q';;
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q'
preexec() { echo -ne '\e[5 q' ;}

# Get syntax highlighting while writiing.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
