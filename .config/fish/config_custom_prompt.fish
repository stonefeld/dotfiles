# ------------ PROMPT ------------ #
function fish_mode_prompt
  set_color -o brwhite
  echo "[ "
  switch $fish_bind_mode
    case default
      echo -en "\e[2 q"
      set_color -o brred
      echo "N"

    case insert
      echo -en "\e[6 q"
      set_color -o brgreen
      echo "I"

    case replace_one
      echo -en "\e[4 q"
      set_color -o bryellow
      echo "R"

    case visual
      echo -en "\e[2 q"
      set_color -o brmagenta
      echo "V"

    case '*'
      echo -en "\e[2 q"
      set_color -o brred
      echo "?"

  end
  set_color -o brwhite
  echo " ]"
  echo " "
  set_color normal
end

function _git_ahead
  set -l commits (command git rev-list --left-right '@{upstream}...HEAD' ^/dev/null)
  if [ $status != 0 ]
    return
  end
  set -l behind (count (for arg in $commits; echo $arg; end | grep '^<'))
  set -l ahead  (count (for arg in $commits; echo $arg; end | grep -v '^<'))
  switch "$ahead $behind"
    case ''
    case '0 0'
      return
    case '* 0'
      set_color yellow
      echo "↑"
      set_color normal
      echo "$ahead "
    case '0 *'
      set_color yellow
      echo "↓"
      set_color normal
      echo "$behind "
    case '*'
      set_color yellow
      echo "↑"
      set_color normal
      echo "$ahead "
      set_color yellow
      echo "↓"
      set_color normal
      echo "$behind "
  end
end


function _git_branch_name
  echo (command git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
end

function _is_git_dirty
  echo (command git status -s --ignore-submodules=dirty ^/dev/null)
end

function fish_prompt
  set -l last_status $status
  set -g yellow ( set_color -o bryellow )
  set -g red    ( set_color -o brred    )
  set -g blue   ( set_color -o brblue   )
  set -g cyan   ( set_color -o brcyan   )
  set -g green  ( set_color -o brgreen  )
  set -g white  ( set_color -o brwhite  )
  set -g normal ( set_color    normal   )

  set -l ahead (_git_ahead)
  set -g whitespace ' '

  if test $last_status = 0
    set status_indicator "$green>>"
  else
    set status_indicator "$red>>"
  end
  set -l cwd $white"[ "$blue(basename (prompt_pwd))$white" ]"

  if [ (_git_branch_name) ]
    set -l git_branch (_git_branch_name)
    set git_info "$white ($cyan$git_branch$white)"
    if [ (_is_git_dirty) ]
      set -l dirty " $yellow✗"
      set git_info "$git_info$dirty"
    else
      set git_info "$white ($blue$git_branch$white)"
    end
  end
  echo -n -s $cwd $git_info $whitespace $ahead $status_indicator
  set_color normal
  echo $whitespace
end
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
# ------ END ENV VARIABLES ------- #
