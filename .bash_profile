#  _               _                           __ _ _
# | |__   __ _ ___| |__       _ __  _ __ ___  / _(_) | ___
# | '_ \ / _` / __| '_ \     | '_ \| '__/ _ \| |_| | |/ _ \
# | |_) | (_| \__ \ | | |    | |_) | | | (_) |  _| | |  __/
# |_.__/ \__,_|___/_| |_|____| .__/|_|  \___/|_| |_|_|\___|
#                      |_____|_|

[[ -f ~/.bashrc ]] && . ~/.bashrc
[[ -f ~/.profile ]] && . ~/.profile

if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
    xlogin
fi
