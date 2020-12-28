# ------------ PROMPT ------------ #
function fish_prompt
  set -l last_status $status
  set -l yellow ( set_color -o bryellow )
  set -g red    ( set_color -o brred    )
  set -g blue   ( set_color -o brblue   )
  set -g cyan   ( set_color -o brcyan   )
  set -l green  ( set_color -o brgreen  )
  set -g white  ( set_color -o brwhite  )
  set -l normal ( set_color    brwhite  )

  set -l ahead (_git_ahead)
  set -g whitespace ' '

  if test $last_status = 0
    set status_indicator "$green>>$normal"
  else
    set status_indicator "$red>>$normal"
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

function fish_mode_prompt
  switch $fish_bind_mode
    case default
      set_color -o brwhite
      echo "[ "
      set_color -o brred
      echo "N"
      set_color -o brwhite
      echo " ]"
    case insert
      set_color -o brwhite
      echo "[ "
      set_color -o brgreen
      echo "I"
      set_color -o brwhite
      echo " ]"
    case replace_one
      set_color -o brwhite
      echo "[ "
      set_color -o bryellow
      echo "R"
      set_color -o brwhite
      echo " ]"
    case visual
      set_color -o brwhite
      echo "[ "
      set_color -o brmagenta
      echo "V"
      set_color -o brwhite
      echo " ]"
    case '*'
      set_color -o brwhite
      echo "[ "
      set_color -o brred
      echo "?"
      set_color -o brwhite
      echo " ]"
  end
  set_color normal
end

function fish_user_key_bindings
  for mode in insert default visual
    bind -M $mode \cf forward-char
  end
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
      echo "$yellow↑$normal_c$ahead$whitespace"
    case '0 *'
      echo "$yellow↓$normal_c$behind$whitespace"
    case '*'
      echo "$yellow↑$normal$ahead $yellow↓$normal_c$behind$whitespace "
  end
end


function _git_branch_name
  echo (command git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
end

function _is_git_dirty
  echo (command git status -s --ignore-submodules=dirty ^/dev/null)
end
# ---------- END PROMPT ---------- #

# ------------ ALIASES ----------- #
# Power functions
alias sn='shutdown now'
alias re='reboot'
alias ss='systemctl suspend'

# ls Replacement
alias ls='exa -lag --color=always --group-directories-first --git'
alias la='exa -a --color=always --group-directories-first'
alias ll='exa -lg --color=always --group-directories-first --git'
alias lt='exa -aT --color=always --group-directories-first'
alias lf='ranger'

# NeoVim shortcut
alias v='nvim'
alias v.='nvim .'
alias vf="fzf --preview 'bat --theme Nord {1}' | xargs -ro nvim"

# Fish keybindings shortcut
alias vk='fish_vi_key_bindings'
alias nk='fish_default_key_bindings'

# LazyGit shortcut
alias lgit='lazygit'

# Python3 shortcut
alias py='python3'

# Pacman
alias pacinstall="pacman -Slq | fzf --multi --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S"
alias pacremove="pacman -Qq | fzf --multi --preview 'pacman -Qi {1}' | xargs -ro sudo pacman -Rns"

# Pip3 Package Update Shortcut
alias pip3_update="pip3 list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U"

# Overwrite confirm
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# Colors
alias ip='ip -color=auto'
alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
# ---------- END ALIASES --------- #

# -------- ENV VARIABLES --------- #
export BAT_THEME="Nord"
export EDITOR="nvim"
# ------ END ENV VARIABLES ------- #

# --------- MANPAGES COLORS ------ #
set -x LESS_TERMCAP_mb (printf "\033[01;31m")  
set -x LESS_TERMCAP_md (printf "\033[01;31m")  
set -x LESS_TERMCAP_me (printf "\033[0m")  
set -x LESS_TERMCAP_se (printf "\033[0m")  
set -x LESS_TERMCAP_so (printf "\033[01;44;33m")  
set -x LESS_TERMCAP_ue (printf "\033[0m")  
set -x LESS_TERMCAP_us (printf "\033[01;32m")  
# ------ END MANPAGES COLORS ----- #
