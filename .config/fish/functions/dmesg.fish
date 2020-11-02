# Defined in - @ line 1
function dmesg --wraps='dmesg --color=always' --description 'alias dmesg dmesg --color=always'
 command dmesg --color=always $argv;
end
