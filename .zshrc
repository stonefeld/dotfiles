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

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^ ' autosuggest-accept

[[ $- != *i* ]] && return

setopt prompt_subst

function parse_git_commit() {
    st=$(git status 2> /dev/null | tail -n 1)
    if [[ $st != "nothing to commit, working tree clean" ]]
    then
        git branch 2> /dev/null | sed -e "/^[^*]/d" -e "s/* \(.*\)/(%F{1}\1%f) /"
    else
        git branch 2> /dev/null | sed -e "/^[^*]/d" -e "s/* \(.*\)/(%F{2}\1%f) /"
    fi
}

PROMPT='%B[ %F{4}%1~%f ] $(parse_git_commit)%F{2}>%f%F{3}>%f%b '

alias sn="shutdown now"
alias re="reboot"
alias ss="systemctl suspend"

alias ..='cd ../'
alias ...='cd ../../'

alias ls="exa -lag --color=always --group-directories-first --git"
alias la="exa -a --color=always --group-directories-first"
alias ll="exa -l --color=always --group-directories-first"
alias lt="exa -aT --color=always --group-directories-first"
alias lf="ranger"

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

alias diff='diff --color=auto'
alias ip='ip -color=auto'
alias dmesg='dmesg --color=always'

alias v='nvim'
alias v.='nvim .'
alias py='python3'

alias pacinstall="pacman -Slq | fzf --multi --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S"
alias pacremove="pacman -Qq | fzf --multi --preview 'pacman -Qi {1}' | xargs -ro sudo pacman -Rns"
alias lgit='lazygit'

export EDITOR='nvim'
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --color fg:#eceff4,hl:#7f8490,fg+:#eceff4,bg+:#3b4252,hl+:#bf616a,info:#bf616a,border:#eceff4,prompt:#bf616a,pointer:#bf616a,marker:#bf616a,spinner:#b48ead,header:#7f8490"
export LESSHISTFILE=/dev/null
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"

# setup key accordingly
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"      beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"       end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"    overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}" backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"    delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"        up-line-or-history
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"      down-line-or-history
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"      backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"     forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"    beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"  end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}" reverse-menu-complete

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

key[Control-Left]="${terminfo[kLFT5]}"
key[Control-Right]="${terminfo[kRIT5]}"

[[ -n "${key[Control-Left]}"  ]] && bindkey -- "${key[Control-Left]}"  backward-word
[[ -n "${key[Control-Right]}" ]] && bindkey -- "${key[Control-Right]}" forward-word
