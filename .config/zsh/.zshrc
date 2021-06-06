#
# ~/.zshrc
#

[[ $- != *i* ]] && return

HISTSIZE=5000
SAVEHIST=10000

bindkey -v
zstyle ':completion:*' cache-path $XDG_CACHE_HOME/zsh/zcompcache

autoload -Uz compinit promptinit
compinit -d $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION
promptinit

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh

setopt autocd
setopt prompt_subst

virtualenv_info() {
    if [[ -n "$VIRTUAL_ENV" ]]; then
        venv="$(cut -d "-" -f 1 <<< ${VIRTUAL_ENV##*/})"
    else
        venv=""
    fi
    [[ -n "$venv" ]] && echo "($venv)"
}

gitdir() { git check-ignore -q . 2>/dev/null; [ "$?" -eq "1" ] && echo 1 || echo 3 }

PROMPT='%B%F{red}[%f%F{yellow}%n%f%F{green}@%f%F{blue}%m%f %F{magenta}%$(gitdir)~%f%F{red}]%f%b%F{white} '
RPROMPT='%B%F{yellow}$(virtualenv_info)%f%b'

alias sn="shutdown now"
alias re="reboot"
alias ss="systemctl suspend"

alias ls="ls -h --color=always --group-directories-first"
alias lf="vifm ."

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

alias v='nvim'
alias v.='nvim .'
alias vf="fzf --preview 'cat {}'| xargs -ro nvim"
alias vim="vim -i NONE"

alias py='python3'
alias pe='pipenv'
alias pyenvinit='eval "$(pyenv init -)"'
alias pip3update="sudo pip3 list --outdated | awk '{print $1}' | tail -n+3 | xargs -r -n1 sudo pip3 install --upgrade"
alias pepyls='pipenv install --dev python-language-server rope pyflakes mccabe pycodestyle pydocstyle autopep8 yapf'
alias pippyls='pip install python-language-server rope pyflakes mccabe pycodestyle pydocstyle autopep8 yapf'

alias mans='man -k . | fzf | sed "s/ \+/ /g" | cut -d " " -f 1 | xargs -r man'

alias lgit='lazygit'
alias ldocker='lazydocker'

alias pacinstall="pacman -Slq | fzf --height 0% --multi --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S"
alias pacremove="pacman -Qq | fzf --height 0% --multi --preview 'pacman -Qi {1}' | xargs -ro sudo pacman -Rns"
alias pacupdate="sudo pacman -Syy && sudo pacman -Su --noconfirm && echo 0 > $XDG_DATA_HOME/updates && status-init"

alias ip='ip -color=auto'
alias diff='diff --color=auto'
alias dmesg='dmesg --color=always'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

alias sys='systemctl'
alias jou='journalctl'

alias monkiflip='mpv "https://www.youtube.com/watch?v=XZ5Uv4JKTU4"'

bindkey '^P' up-line-or-history
bindkey '^N' down-line-or-history

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