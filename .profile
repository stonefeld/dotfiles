#                   __ _ _
#  _ __  _ __ ___  / _(_) | ___
# | '_ \| '__/ _ \| |_| | |/ _ \
# | |_) | | | (_) |  _| | |  __/
# | .__/|_|  \___/|_| |_|_|\___|
# |_|

# Export important global variables.
export PATH=$PATH:~/.local/bin/:~/.local/bin/statusline/:~/.local/share/cargo/bin/
export SHELL=/bin/zsh
export EDITOR='nvim'
export TERMINAL='st'
export TERM='xterm-256color'
export BROWSER='brave'
export LC_COLLATE="C"

# Some default option.
export LESSHISTFILE=-
export QT_QPA_PLATFORMTHEME=qt5ct
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --color=16"
export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude={.git,.venv,node_modules}"
export VIRTUAL_ENV_DISABLE_PROMPT=1

# Cleaning home directory.
export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc
export XSERVERRC="$XDG_CONFIG_HOME"/X11/xserverrc
export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export ZDOTDIR="$XDG_CONFIG_HOME"/zsh
export HISTFILE="$XDG_DATA_HOME"/history
export PASSWORD_STORE_DIR="$XDG_DATA_HOME"/pass
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export WGETRC="$XDG_CONFIG_HOME"/wgetrc
export TEXMFHOME=$XDG_DATA_HOME/texmf
export TEXMFVAR=$XDG_CACHE_HOME/texlive/texmf-var
export TEXMFCONFIG=$XDG_CONFIG_HOME/texlive/texmf-config
export VSCODE_PORTABLE="$XDG_DATA_HOME"/vscode
export PYTHONSTARTUP=$XDG_CONFIG_HOME/python/pythonrc
export PYENV_ROOT="$XDG_DATA_HOME"/pyenv
export MYSQL_HISTFILE="$XDG_DATA_HOME"/mysql_history
export IPYTHONDIR="$XDG_CONFIG_HOME"/jupyter
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME"/jupyter
export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node_repl_history
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
export GOPATH="$XDG_DATA_HOME"/go
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java

# Setting less colors.
export LESS=-R
export LESS_TERMCAP_mb=$'\E[1;31m'
export LESS_TERMCAP_md=$'\E[1;36m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_us=$'\E[1;32m'
export LESS_TERMCAP_ue=$'\E[0m'
