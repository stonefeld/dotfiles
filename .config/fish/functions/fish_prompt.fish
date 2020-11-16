function fish_prompt

  set -l last_status $status
  set -l yellow (set_color -o "#EBCB8B")
  set -g red (set_color -o "#BF616A")
  set -g blue (set_color -o "#81A1C1")
  set -g cyan (set_color -o "#8FBCBB")
  set -l green (set_color -o "#A3BE8C")
  set -g white (set_color -o "#D8DEE9")
  set -g normal (set_color brwhite)

  set -l ahead (_git_ahead)
  set -g whitespace ' '

  if test $last_status = 0
    #set initial_indicator "$green➜"
    set status_indicator "$blue>>$normal"
  else
    #set initial_indicator "$red➜"
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
  # Notify if a command took more than 5 minutes
  if [ "$CMD_DURATION" -gt 300000 ]
    echo The last command took (math "$CMD_DURATION/1000") seconds.
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
    case ''     # no upstream
    case '0 0'  # equal to upstream
      return
    case '* 0'  # ahead of upstream
      echo "$cyan↑$normal_c$ahead$whitespace"
    case '0 *'  # behind upstream
      echo "$cyan↓$normal_c$behind$whitespace"
    case '*'    # diverged from upstream
      echo "$cyan↑$normal$ahead $cyan↓$normal_c$behind$whitespace"
  end
end

function _git_branch_name
  echo (command git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
end

function _is_git_dirty
  echo (command git status -s --ignore-submodules=dirty ^/dev/null)
end
