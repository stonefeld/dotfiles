# Defined in - @ line 1
function la --wraps='exa -a --color=always --group-directories-first' --description 'alias la exa -a --color=always --group-directories-first'
  exa -a --color=always --group-directories-first $argv;
end
