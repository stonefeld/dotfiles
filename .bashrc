#
# ~/.bashrc
#

[[ $- != *i* ]] && return

parse_git_branch() {
     git branch 2> /dev/null | sed -e "/^[^*]/d" -e "s/* \(.*\)/(\1) /"
}

PS1="\[\e[1;37m\][\[\e[1;31m\]\u\[\e[1;37m\]@\[\e[1;34m\]\h\[\e[1;37m\]]\[\e[1;32m\] \W\[\e[1;33m\] \$(parse_git_branch)\[\e[1;37m\]\$\[\e[0m\] "

alias ssn="sudo shutdown now"
alias sr="sudo reboot"
alias ss="systemctl suspend"

alias ..='cd ../'
alias ...='cd ../../'

alias ls="exa -al --color=always --group-directories-first"
alias la="exa -a --color=always --group-directories-first"
alias ll="exa -l --color=always --group-directories-first"
alias lt="exa -aT --color=always --group-directories-first"
alias l.='exa -a | egrep "^\."'

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

alias diff='diff --color=auto'
alias ip='ip -color=auto'
alias dmesg='dmesg --color=always'

alias edit='nvim'

alias whatsapp='firefox https://web.whatsapp.com/'

man() {
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}

export LESS=-R
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline
