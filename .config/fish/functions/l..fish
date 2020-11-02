# Defined in - @ line 1
function l. --wraps=exa\ -a\ \|\ egrep\ \"\^\\.\" --description alias\ l.\ exa\ -a\ \|\ egrep\ \"\^\\.\"
  exa -a | egrep "^\." $argv;
end
