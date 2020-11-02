# Defined in - @ line 1
function ls --wraps='exa -lag --color=always --group-directories-first --git' --description 'alias ls exa -lag --color=always --group-directories-first --git'
  exa -lag --color=always --group-directories-first --git $argv;
end
