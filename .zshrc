# Lines configured by zsh-newuser-install
HISTFILE=~/.zshhistory
HISTSIZE=5000
SAVEHIST=10000
bindkey -v

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/master/.zshrc'

autoload -Uz compinit
compinit

autoload -Uz promptinit
promptinit

# End of lines added by compinstall

zstyle ':completion:*' menu select
setopt COMPLETE_ALIASES
zstyle ':completion::complete:*' gain-privileges 1

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
bindkey '^F' autosuggest-accept

[[ $- != *i* ]] && return

setopt prompt_subst
stty stop undef
setopt autocd

# function parse_git_commit() {
#     st=$(git status 2> /dev/null | tail -n 1)
#     if [[ $st != "nothing to commit, working tree clean" ]]
#     then
#         git branch 2> /dev/null | sed -e "/^[^*]/d" -e "s/* \(.*\)/(%F{1}\1%f) /"
#     else
#         git branch 2> /dev/null | sed -e "/^[^*]/d" -e "s/* \(.*\)/(%F{2}\1%f) /"
#     fi
# }
# PROMPT='%B[ %F{4}%1~%f ] $(parse_git_commit)%F{2}>%f%F{3}>%f%b '

echo $(zsh --version)
cowsay -f small $(fortune)
source <("/usr/local/bin/starship" init zsh --print-full-init)

alias sn="shutdown now"
alias re="reboot"
alias ss="systemctl suspend"

alias ls="exa -lag -a --color=always --group-directories-first"
alias la="exa -a --color=always --group-directories-first"
alias ll="exa -lg --color=always --group-directories-first"
alias lt="exa -aT --color=always --group-directories-first"
alias lf="ranger"

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

alias v='nvim'
alias v.='nvim .'
alias vf="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'| xargs -ro nvim"
alias vim="vim -i NONE"

alias py='python3'
alias pe='pipenv'
alias pyenvinit='eval "$(pyenv init -)"'
alias pip3update="sudo pip3 list --outdated | awk '{print $1}' | tail -n+3 | xargs -r -n1 sudo pip3 install --upgrade"
alias pepyls='pipenv install --dev python-language-server rope pyflakes mccabe pycodestyle pydocstyle autopep8 yapf'
alias pippyls='pip install python-language-server rope pyflakes mccabe pycodestyle pydocstyle autopep8 yapf'

alias lgit='lazygit'

alias pacinstall="pacman -Slq | fzf --height 0% --multi --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S"
alias pacremove="pacman -Qq | fzf --height 0% --multi --preview 'pacman -Qi {1}' | xargs -ro sudo pacman -Rns"
alias pacupdate="sudo pacman -Syy && sudo pacman -Su"

alias ip='ip -color=auto'
alias diff='diff --color=auto'
alias dmesg='dmesg --color=always'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

alias sys='systemctl'
alias jou='journalctl'

alias monkiflip='mpv "https://www.youtube.com/watch?v=XZ5Uv4JKTU4"'

export EDITOR='nvim'
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --color fg:#eceff4,hl:#7f8490,fg+:#eceff4,bg+:#3b4252,hl+:#bf616a,info:#bf616a,border:#eceff4,prompt:#bf616a,pointer:#bf616a,marker:#bf616a,spinner:#b48ead,header:#7f8490"
export LESSHISTFILE=/dev/null
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export PATH=$PATH:~/.local/bin/

bindkey '^P' up-line-or-history
bindkey '^N' down-line-or-history
