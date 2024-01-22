#    _               _
#   | |__   __ _ ___| |__  _ __ ___
#   | '_ \ / _` / __| '_ \| '__/ __|
#  _| |_) | (_| \__ \ | | | | | (__
# (_)_.__/ \__,_|___/_| |_|_|  \___|

[[ $- != *i* ]] && return

PS1='\[\e[1;32m\]\u@\h\[\e[1;37m\]:\[\e[1;34m\]\w\[\e[0;37m\]\$ '

alias psn='shutdown now'
alias pre='reboot'
alias pss='systemctl suspend'

alias ls='ls -h --color=always --group-directories-first'
alias ll='ls -lah --color=always --group-directories-first'

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

alias sudo='sudo '
alias doas='doas '

alias sys='systemctl'
alias jou='journalctl'

alias edwm='startx $XINITRC dwm'
alias ei3='startx $XINITRC i3'
alias eqtile='startx $XINITRC qtile'
alias egnome='XDG_SESSION_TYPE=wayland dbus-run-session gnome-session'
alias ekde='DESKTOP_SESSION=plasma; startx $XINITRC plasma'

echo -ne '\e[1 q'
