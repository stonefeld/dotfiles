#    _               _
#   | |__   __ _ ___| |__  _ __ ___
#   | '_ \ / _` / __| '_ \| '__/ __|
#  _| |_) | (_| \__ \ | | | | | (__
# (_)_.__/ \__,_|___/_| |_|_|  \___|

[[ $- != *i* ]] && return

PS1='\[\e[1;31m\][\[\e[1;33m\]\u\[\e[1;32m\]@\[\e[1;34m\]\h \[\e[1;35m\]\W\[\e[1;31m\]]\[\e[0;37m\]$ '

alias psn='shutdown now'
alias pre='reboot'
alias pss='systemctl suspend'

alias ls='ls -h --color=always --group-directories-first'
alias vim='vim -i NONE'

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

alias ip='ip -color=auto'
alias diff='diff --color=auto'
alias dmesg='dmesg --color=always'
alias less='less -r'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

alias sys='systemctl'
alias jou='journalctl'

alias edwm='startx $XDG_CONFIG_HOME/X11/xinitrc dwm'
alias eqtile='startx $XDG_CONFIG_HOME/X11/xinitrc qtile'
alias egnome='XDG_SESSION_TYPE=wayland dbus-run-session gnome-session'
alias ekde='DESKTOP_SESSION=plasma; startx $XDG_CONFIG_HOME/X11/xinitrc plasma'
alias eopenbox='startx $XDG_CONFIG_HOME/X11/xinitrc openbox'

echo -ne '\e[1 q'
