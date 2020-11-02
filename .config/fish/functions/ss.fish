# Defined in - @ line 1
function ss --wraps='systemctl suspend' --description 'alias ss systemctl suspend'
  systemctl suspend $argv;
end
