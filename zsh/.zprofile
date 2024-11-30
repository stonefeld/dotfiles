# xdg directories
export XDG_CACHE_HOME="$HOME"/.cache
export XDG_CONFIG_HOME="$HOME"/.config
export XDG_DATA_HOME="$HOME"/.local/share

# set additional paths and locale
export PATH=~/.local/bin/:~/.local/share/pyenv/bin/:~/.local/share/npm/bin/:~/.local/share/cargo/bin/:~/.local/share/go/bin/:$PATH

# override these defaults
export BROWSER='firefox'
export EDITOR='nvim'
export TERMINAL='kitty'
export MANPAGER='nvim +Man!'

# dark theme everywhere
# export GTK_THEME=Adwaita:dark
# export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc:"$XDG_CONFIG_HOME"/gtk-2.0/gtkrc.mine
# export QT_QPA_PLATFORMTHEME=qt5ct

# configuring the system
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --color=16'
export LESSHISTFILE=-
export LESS='-R --use-color -Dd+r$Du+b$'
export NEXT_TELEMETRY_DISABLED=1

# cleaning home directory
export PASSWORD_STORE_DIR="$XDG_DATA_HOME"/pass
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export WGETRC="$XDG_CONFIG_HOME"/wgetrc
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
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle
export VSCODE_PORTABLE="$XDG_DATA_HOME"/vscode
export PLATFORMIO_HOME_DIR="$XDG_DATA_HOME"/platformio
export SOLARGRAPH_CACHE="$XDG_CACHE_HOME"/solargraph
export BUNDLE_APP_CONFIG="$XDG_DATA_HOME"/bundle
export PSQLRC="$XDG_CONFIG_HOME"/pg/psqlrc
export PSQL_HISTORY="$XDG_CACHE_HOME"/psql_history
export PGPASSFILE="$XDG_CONFIG_HOME"/pg/pgpass
export PGSERVICEFILE="$XDG_CONFIG_HOME"/pg/pg_service.conf
