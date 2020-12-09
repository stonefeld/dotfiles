# ------------ PROMPT ------------ #
function fish_prompt

  set -l last_status $status
  set -l yellow (set_color -o "#EBCB8B")
  set -g red    (set_color -o "#BF616A")
  set -g blue   (set_color -o "#81A1C1")
  set -g cyan   (set_color -o "#8FBCBB")
  set -l green  (set_color -o "#A3BE8C")
  set -g white  (set_color -o "#D8DEE9")
  set -g normal (set_color     brwhite )

  set -l ahead (_git_ahead)
  set -g whitespace ' '

  if test $last_status = 0
    set status_indicator "$blue>>$normal"
  else
    set status_indicator "$red>>$normal"
  end
  set -l cwd $white"[ "$blue(basename (prompt_pwd))$white" ]"

  if [ (_git_branch_name) ]
    set -l git_branch (_git_branch_name)
    set git_info "$white ($cyan$git_branch$white)"
    if [ (_is_git_dirty) ]
      set -l dirty "$cyan ✗"
      set git_info "$git_info$dirty"
    else
      set git_info "$white ($blue$git_branch$white)"
    end
  end
  echo -n -s $cwd $git_info $whitespace $ahead $status_indicator $normal $whitespace

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
      echo "$cyan↑$normal_c$ahead$whitespace"
    case '0 *'
      echo "$cyan↓$normal_c$behind$whitespace"
    case '*'
      echo "$cyan↑$normal$ahead $cyan↓$normal_c$behind$whitespace"
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
function re --wraps=reboot --description 'alias re reboot'
  reboot  $argv;
end
function sn --wraps='shutdown now' --description 'alias sn shutdown now'
  shutdown now $argv;
end
function ss --wraps='systemctl suspend' --description 'alias ss systemctl suspend'
  systemctl suspend $argv;
end

# ls Replacement
function ls --wraps='exa -lag --color=always --group-directories-first --git' --description 'alias ls exa -lag --color=always --group-directories-first --git'
  exa -lag --color=always --group-directories-first --git $argv;
end
function la --wraps='exa -a --color=always --group-directories-first' --description 'alias la exa -a --color=always --group-directories-first'
  exa -a --color=always --group-directories-first $argv;
end
function ll --wraps='exa -l --color=always --group-directories-first' --description 'alias ll exa -l --color=always --group-directories-first'
  exa -l --color=always --group-directories-first $argv;
end
function lt --wraps='exa -aT --color=always --group-directories-first' --description 'alias lt exa -aT --color=always --group-directories-first'
  exa -aT --color=always --group-directories-first $argv;
end
function l. --wraps=exa\ -a\ \|\ egrep\ \"\^\\.\" --description alias\ l.\ exa\ -a\ \|\ egrep\ \"\^\\.\"
  exa -a | egrep "^\." $argv;
end

# NeoVim shortcut
function v --wraps=nvim --description 'alias v nvim'
  nvim  $argv;
end
function v. --wraps='nvim .' --description 'alias v. nvim .'
  nvim . $argv;
end

# LazyGit shortcut
function lgit --wraps=lazygit --description 'alias lgit lazygit'
  lazygit  $argv;
end

# Python3 shortcut
function py --wraps=python3 --description 'alias py python3'
  python3  $argv;
end

# Pacman
function pacinstall --wraps=pacman\ -Slq\ \|\ fzf\ --multi\ --preview\ \'pacman\ -Si\ \{1\}\'\ \|\ xargs\ -ro\ sudo\ pacman\ -S --description alias\ pacinstall\ pacman\ -Slq\ \|\ fzf\ --multi\ --preview\ \'pacman\ -Si\ \{1\}\'\ \|\ xargs\ -ro\ sudo\ pacman\ -S
  pacman -Slq | fzf --multi --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S $argv;
end
function pacremove --wraps=pacman\ -Qq\ \|\ fzf\ --multi\ --preview\ \'pacman\ -Qi\ \{1\}\'\ \|\ xargs\ -ro\ sudo\ pacman\ -Rns --description alias\ pacremove\ pacman\ -Qq\ \|\ fzf\ --multi\ --preview\ \'pacman\ -Qi\ \{1\}\'\ \|\ xargs\ -ro\ sudo\ pacman\ -Rns
  pacman -Qq | fzf --multi --preview 'pacman -Qi {1}' | xargs -ro sudo pacman -Rns $argv;
end

# Pip3 Package Update Shortcut
function pip3-update --wraps=pip3\ list\ --outdated\ --format=freeze\ \|\ grep\ -v\ \'\^\\-e\'\ \|\ cut\ -d\ =\ -f\ 1\ \ \|\ xargs\ -n1\ pip\ install\ -U --description alias\ pip3-update\ pip3\ list\ --outdated\ --format=freeze\ \|\ grep\ -v\ \'\^\\-e\'\ \|\ cut\ -d\ =\ -f\ 1\ \ \|\ xargs\ -n1\ pip\ install\ -U
  pip3 list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U $argv;
end

# Overwrite confirm
function cp --wraps='cp -i' --description 'alias cp cp -i'
 command cp -i $argv;
end
function mv --wraps='mv -i' --description 'alias mv mv -i'
 command mv -i $argv;
end
function rm --wraps='rm -i' --description 'alias rm rm -i'
 command rm -i $argv;
end

# Colors
function ip --wraps='ip -color=auto' --description 'alias ip ip -color=auto'
 command ip -color=auto $argv;
end
function diff --wraps='diff --color=auto' --description 'alias diff diff --color=auto'
 command diff --color=auto $argv;
end
function dmesg --wraps='dmesg --color=always' --description 'alias dmesg dmesg --color=always'
 command dmesg --color=always $argv;
end
function grep --wraps='grep --color=auto' --description 'alias grep grep --color=auto'
 command grep --color=auto $argv;
end
function egrep --wraps='egrep --color=auto' --description 'alias egrep egrep --color=auto'
 command egrep --color=auto $argv;
end
function fgrep --wraps='fgrep --color=auto' --description 'alias fgrep fgrep --color=auto'
 command fgrep --color=auto $argv;
end
# ---------- END ALIASES --------- #
