#            _
#    _______| |__  _ __ ___
#   |_  / __| '_ \| '__/ __|
#  _ / /\__ \ | | | | | (__
# (_)___|___/_| |_|_|  \___|

[[ $- != *i* ]] && return

# ---------- PROMPT ---------- #
# Required line to automatically update the prompt.
setopt prompt_subst

# Load advanced completion system.
autoload -U compinit
compinit -d ${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump-$ZSH_VERSION
zstyle ':completion:*' menu select cache-path ${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompcache-$ZSH_VERSION

# Save most recent 1000 lines on history file.
SAVEHIST=1000

# Small function to detect an active virtual environment and return the name.
# Avoid creating virtual environments with dashes inside the name.
virtualenv_info() {
	[ -n "$VIRTUAL_ENV" ] && echo "%B%F{yellow}($(sed 's/\-[a-zA-Z0-9]*$//' <<< ${VIRTUAL_ENV##*/}))%f%b" 2>/dev/null
}

# Small function to detect if the directory is a git repository and change
# prompt's current working directory length to 1.
gitdir() {
	git check-ignore -q . 2>/dev/null; [ "$?" -eq "1" ] && echo 1 || echo 3
}

# Setting up the normal prompt.
PROMPT='%B%F{red}[%f%F{yellow}%n%f%F{green}@%f%F{blue}%m%f %F{magenta}%$(gitdir)~%f%F{red}]%f%b%F{white}$ '

# The right prompt displays the virtual environment's name.
RPROMPT='$(virtualenv_info)'

# ---------- ALIASES ---------- #
# System power.
alias psn="shutdown now"
alias pre="reboot"
alias pss="systemctl suspend"

# Pacman shortcuts.
alias pacinstall="pacman -Slq | fzf --height 0% --multi --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S"
alias pacremove="pacman -Qq | fzf --height 0% --multi --preview 'pacman -Qi {1}' | xargs -ro sudo pacman -Rns"
alias pacupdate="sudo pacman -Syy && sudo pacman -Su --noconfirm && echo 0 > ${XDG_DATA_HOME:-$HOME/.local/share}/updates && pkill -RTMIN+6 dwmblocks"

# AUR helper shortcuts using fzf.
if command -v paru &>/dev/null; then
	alias parinstall="paru -Slq | fzf --height 0% --multi --preview 'paru -Si {1}' | xargs -ro paru -S --noconfirm"
elif command -v yay &>/dev/null; then
	alias yayinstall="yay -Slq | fzf --height 0% --multi --preview 'yay -Si {1}' | xargs -ro yay -S"
fi

# Utilities with fzf
alias cf='cd "$(find ~ -maxdepth 5 -type d | sed "/\.git/d;/\.venv/d;/node_modules/d;/virtualenv*/d" | fzf)"'
alias sr='less "$(find ~ -maxdepth 5 -type f | sed "/\.git/d;/\.venv/d;/node_modules/d;/virtualenv*/d" | fzf)"'

# Some ls command replacements.
if ! command -v exa &>/dev/null; then
	alias ls="LC_COLLATE=C ls -h --color=always --group-directories-first"
else
	alias ls="exa -g --color=always --group-directories-first"
fi
alias lf="vifm ."

# Avoid overriding.
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# Pass aliases to sudo.
alias sudo='sudo '

# Git shortcuts.
alias gis='git status'
alias gid='git diff'
alias gio='git show'
alias gia='git add'
alias gic='git commit'
alias gil='git log --graph'
alias gib='git branch'
alias gih='git checkout'
alias gip='git push'
alias giu='git pull'
alias gif='git fetch'
alias gim='git merge'
alias gir='git remote'

# Neovim shortcuts.
alias e="$EDITOR"
alias ee="$EDITOR ."
alias ef="fzf --preview 'cat {}'| xargs -ro $EDITOR"
alias vim="echo -ne '\e[1 q' && vim -i NONE"
alias gvim="gvim -i NONE"

# Python and pip shortcuts
alias py='python3'
alias pe='pipenv'
alias pyenvinit='eval "$(pyenv init -)"'
alias pip3update="sudo pip3 list --outdated | sed 's/\s\+/ /g' | cut -d ' ' -f 1 | tail -n+3 | xargs -r -n1 sudo pip3 install --upgrade"
alias pippyls='pip install python-language-server rope pyflakes mccabe pycodestyle pydocstyle autopep8 yapf'
alias pepyls='pipenv install --dev python-language-server rope pyflakes mccabe pycodestyle pydocstyle autopep8 yapf'

# Show all manpages on a fzf table and select the one to read.
alias mans='man -k . | fzf | sed "s/ \+/ /g" | cut -d " " -f 1 | xargs -r man'

# Lazygit shortctut.
alias lgit='lazygit'

# NetworkManager commands shortcuts.
alias wcon='nmcli device wifi connect'
alias wls='nmcli device wifi list'

# Open irssi and specify the config and data folder.
alias irssi='irssi --config="$XDG_CONFIG_HOME"/irssi/config --home="$XDG_DATA_HOME"/irssi'

# Getting colored outputs.
alias ip='ip -color=auto'
alias diff='diff --color=auto'
alias dmesg='dmesg --color=always'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# System shortcuts.
alias sys='systemctl'
alias jou='journalctl'

# Monkiflip.
alias monkiflip='mpv "https://www.youtube.com/watch?v=XZ5Uv4JKTU4" &>/dev/null'

# Manage dotfiles.
alias dotfiles='/usr/bin/git --git-dir=$HOME/.local/share/dotfiles --work-tree=$HOME'

# File decompresser and extracter.
ex() {
	if [ ! -z "$*" ]; then
		for i in $*; do
			if [ -f "$i" ]; then
				case $i in
					*.tar.bz2) tar -xjf $i;;
					*.tar.gz)  tar -xzf $i;;
					*.rar)     unrar -x $i;;
					*.gz)      gunzip $i;;
					*.tar)     tar -xf $i;;
					*.zip)     unzip $i -d ./${i%.*};;
					*.Z)       uncompress $i;;
					*.7z)      7z -x $i;;
					*)         echo "ex: cannot extract '$i': Filetype not supported";;
				esac
			else
				echo "ex: cannot access '$i': No such file or directory"
			fi
		done
	else
		echo "ex [FILE...]"
	fi
}

# ---------- KEYBINDINGS ---------- #
bindkey '^P' up-line-or-history      # Ctrl+p
bindkey '^N' down-line-or-history    # Ctrl+n
bindkey '^[[A' up-line-or-history    # Up arrow
bindkey '^[[B' down-line-or-history  # Down arrow
bindkey '^[[D' backward-char         # Left arrow
bindkey '^[[C' forward-char          # Right arrow
bindkey '^[[1;5D' backward-word      # Ctrl+Left arrow
bindkey '^[[1;5C' forward-word       # Ctrl+Right arrow
bindkey '^[[H' beginning-of-line     # Home
bindkey '^[[4~' end-of-line          # End
bindkey '^[[4h' overwrite-mode       # Insert
bindkey '^[[P' delete-char           # Delete
bindkey '^[[Z' reverse-menu-complete # Shift+Tab
bindkey '^[[5~' beginning-of-history # PageUp
bindkey '^[[6~' end-of-history       # PageDown

# ---------- VI MODE ---------- #
# Activate vi mode.
bindkey -v

# Remove mode switching delay.
KEYTIMEOUT=5

# Change cursor shape for different vi modes.
function zle-keymap-select () {
	case $KEYMAP in
		vicmd)      echo -ne '\e[1 q';;
		viins|main) echo -ne '\e[5 q';;
	esac
}
zle -N zle-keymap-select

# Use beam shape cursor on startup.
echo -ne '\e[5 q'

# Use beam shape for each new prompt.
fix_cursor() { echo -ne '\e[5 q'; }
precmd_functions+=(fix_cursor)

# ---------- TITLE ---------- #
# Print the username, the hostname and the path.
function set_title () { print -Pn -- '\e]2;%n@%m %~\a'; }

# Rewrite the title for each new prompt.
precmd_functions+=(set_title)

# ---------- EXTRAS ---------- #
# Syntax highlighting.
if [ -d /usr/share/zsh/plugins/zsh-syntax-highlighting ]; then
	source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
elif [ -d ${ZDOTDIR:-$HOME/.config/zsh}/zsh-syntax-highlighting ]; then
	source ${ZDOTDIR:-$HOME/.config/zsh}/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
fi
