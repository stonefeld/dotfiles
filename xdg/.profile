#                     __ _ _
#    _ __  _ __ ___  / _(_) | ___
#   | '_ \| '__/ _ \| |_| | |/ _ \
#  _| |_) | | | (_) |  _| | |  __/
# (_) .__/|_|  \___/|_| |_|_|\___|
#   |_|

# check if exists and export it
check() {
    if command -v "$1" &>/dev/null; then
        export "$2"="$1"
    fi
}

# xdg directories
export XDG_CACHE_HOME="$HOME"/.cache
export XDG_CONFIG_HOME="$HOME"/.config
export XDG_DATA_HOME="$HOME"/.local/share

# set additional paths and locale
export PATH=~/.local/bin/:~/.local/share/cargo/bin/:$PATH
export LC_COLLATE="C"

# set default applications
command -v nvim &>/dev/null && { export EDITOR="nvim"; export MANPAGER='nvim +Man!'; }
check /bin/zsh SHELL
check alacritty TERMINAL
check vifmrun TERMFM
check brave BROWSER

# override those defaults
export BROWSER="firefox"

# configuring the system
export LESSHISTFILE=-
export QT_QPA_PLATFORMTHEME=qt5ct
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --color=16"
export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude={.git,.venv,node_modules}"
export VIRTUAL_ENV_DISABLE_PROMPT=1
export RANGER_DEVICONS_SEPARATOR="  "
export NEXT_TELEMETRY_DISABLED=1
export HISTSIZE=10000

# cleaning home directory
export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc
export XSERVERRC="$XDG_CONFIG_HOME"/X11/xserverrc
export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export HISTFILE="$XDG_CACHE_HOME"/history
export PASSWORD_STORE_DIR="$XDG_DATA_HOME"/pass
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export WGETRC="$XDG_CONFIG_HOME"/wgetrc
export NOTMUCH_CONFIG="$XDG_CONFIG_HOME"/notmuch/config
export MPLAYER_HOME="$XDG_CONFIG_HOME"/mplayer
export TEXMFHOME="$XDG_DATA_HOME"/texmf
export TEXMFVAR="$XDG_CACHE_HOME"/texlive/texmf-var
export TEXMFCONFIG="$XDG_CONFIG_HOME"/texlive/texmf-config
export PYTHONSTARTUP="$XDG_CONFIG_HOME"/python/pythonrc
export PYENV_ROOT="$XDG_DATA_HOME"/pyenv
export RBENV_ROOT="$XDG_DATA_HOME"/rbenv
export IPYTHONDIR="$XDG_CONFIG_HOME"/jupyter
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME"/jupyter
export MYSQL_HISTFILE="$XDG_DATA_HOME"/mysql_history
export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node_repl_history
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
export GOPATH="$XDG_DATA_HOME"/go
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle
export VSCODE_PORTABLE="$XDG_DATA_HOME"/vscode
export PLATFORMIO_HOME_DIR="$XDG_DATA_HOME"/platformio
export SOLARGRAPH_CACHE="$XDG_CACHE_HOME"/solargraph
export BUNDLE_APP_CONFIG="$XDG_DATA_HOME"/bundle
export PSQLRC="$XDG_CONFIG_HOME"/pg/psqlrc
export PSQL_HISTORY="$XDG_CACHE_HOME"/psql_history
export PGPASSFILE="$XDG_CONFIG_HOME"/pg/pgpass
export PGSERVICEFILE="$XDG_CONFIG_HOME"/pg/pg_service.conf
