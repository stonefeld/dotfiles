#
# ~/.bashrc
#

[[ $- != *i* ]] && return

# parse_git_branch() {
#     git branch 2> /dev/null | sed -e "/^[^*]/d" -e "s/* \(.*\)/(\1) /"
# }

# PS1="\[\e[1;37m\][\[\e[1;31m\]\u\[\e[1;37m\]@\[\e[1;34m\]\h\[\e[1;37m\]]\[\e[1;32m\] \W\[\e[1;33m\] \$(parse_git_branch)\[\e[1;37m\]\$\[\e[0m\] "
PS1="\[\e[0;37m\][\[\e[0;32m\]\u\[\e[0;37m\]@\h \W]\$ "

alias ssn="sudo shutdown now"
alias sr="sudo reboot"
alias ss="systemctl suspend"

alias ls="exa -lag -a --color=always --group-directories-first"
alias la="exa -a --color=always --group-directories-first"
alias ll="exa -lg --color=always --group-directories-first"
alias lt="exa -aT --color=always --group-directories-first"
alias lf="ranger"

alias v='nvim'
alias v.='nvim .'
alias vf="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'| xargs -ro nvim"

alias lgit='lazygit'

alias py='python3'
alias pyenvinit='pyenv init - | source'
alias pip3update="sudo pip3 list --outdated | awk '{print $1}' | tail -n+3 | xargs -r -n1 sudo pip3 install --upgrade"
alias pe='pipenv'

alias pacinstall="pacman -Slq | fzf --height 0% --multi --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S"
alias pacremove="pacman -Qq | fzf --height 0% --multi --preview 'pacman -Qi {1}' | xargs -ro sudo pacman -Rns"

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

alias ip='ip -color=auto'
alias diff='diff --color=auto'
alias dmesg='dmesg --color=always'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

export EDITOR='nvim'
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --color fg:#eceff4,hl:#7f8490,fg+:#eceff4,bg+:#3b4252,hl+:#bf616a,info:#bf616a,border:#eceff4,prompt:#bf616a,pointer:#bf616a,marker:#bf616a,spinner:#b48ead,header:#7f8490"
export LESSHISTFILE=/dev/null
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
