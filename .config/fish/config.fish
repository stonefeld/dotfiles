# ------------ PROMPT ------------ #
echo (fish --version)
function fish_greeting
  cowsay -f small (fortune)
end
set fish_greeting
starship init fish | source
# ---------- END PROMPT ---------- #

# ---------- KEY BINDINGS ----------- #
function fish_user_key_bindings
  fzf_key_bindings
  for mode in insert default visual
    bind -M $mode \cf forward-char
  end
end
# -------- END KEY BINDINGS --------- #

# ------------ ALIASES ----------- #
# Power functions
alias sn='shutdown now'
alias re='reboot'
alias ss='systemctl suspend'

# ls Replacement
alias ls='exa -lag -a --color=always --group-directories-first'
alias la='exa -a --color=always --group-directories-first'
alias ll='exa -lg --color=always --group-directories-first'
alias lt='exa -aT --color=always --group-directories-first'
alias lf='ranger'

# NeoVim shortcut
alias v='nvim'
alias v.='nvim .'
alias vf="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'| xargs -ro nvim"

# Fish keybindings shortcut
alias vk='fish_vi_key_bindings'
alias nk='fish_default_key_bindings'

# LazyGit shortcut
alias lgit='lazygit'

# Python3 shortcut
alias py='python3'
alias pyenvinit='pyenv init - | source'
alias pip3update="sudo pip3 list --outdated | awk '{print $1}' | tail -n+3 | xargs -r -n1 sudo pip3 install --upgrade"
alias pe='pipenv'

# Pacman
alias pacinstall="pacman -Slq | fzf --height 0% --multi --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S"
alias pacremove="pacman -Qq | fzf --height 0% --multi --preview 'pacman -Qi {1}' | xargs -ro sudo pacman -Rns"

# Overwrite confirm
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# Colors
alias ip='ip -color=auto'
alias diff='diff --color=auto'
alias dmesg='dmesg --color=always'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
# ---------- END ALIASES --------- #

# -------- ENV VARIABLES --------- #
export EDITOR='nvim'
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --color fg:#eceff4,hl:#7f8490,fg+:#eceff4,bg+:#3b4252,hl+:#bf616a,info:#bf616a,border:#eceff4,prompt:#bf616a,pointer:#bf616a,marker:#bf616a,spinner:#b48ead,header:#7f8490"
export LESSHISTFILE=/dev/null
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export BAT_THEME="1337"
set PATH ~/.local/bin $PATH
# ------ END ENV VARIABLES ------- #
