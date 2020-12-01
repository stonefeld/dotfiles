# Defined in - @ line 1
function pacinstall --wraps=pacman\ -Slq\ \|\ fzf\ --multi\ --preview\ \'pacman\ -Si\ \{1\}\'\ \|\ xargs\ -ro\ sudo\ pacman\ -S --description alias\ pacinstall\ pacman\ -Slq\ \|\ fzf\ --multi\ --preview\ \'pacman\ -Si\ \{1\}\'\ \|\ xargs\ -ro\ sudo\ pacman\ -S
  pacman -Slq | fzf --multi --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S $argv;
end
