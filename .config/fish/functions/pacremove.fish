# Defined in - @ line 1
function pacremove --wraps=pacman\ -Qq\ \|\ fzf\ --multi\ --preview\ \'pacman\ -Qi\ \{1\}\'\ \|\ xargs\ -ro\ sudo\ pacman\ -Rns --description alias\ pacremove\ pacman\ -Qq\ \|\ fzf\ --multi\ --preview\ \'pacman\ -Qi\ \{1\}\'\ \|\ xargs\ -ro\ sudo\ pacman\ -Rns
  pacman -Qq | fzf --multi --preview 'pacman -Qi {1}' | xargs -ro sudo pacman -Rns $argv;
end
