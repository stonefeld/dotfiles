# Export important global variables.
export PATH=$PATH:~/.local/bin/:~/.local/bin/statusline/
export SHELL=/bin/zsh
export EDITOR='nvim'
export BROWSER='brave'
export LC_COLLATE="C"

# Some default option.
export LESSHISTFILE=-
export QT_QPA_PLATFORMTHEME=qt5ct
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --color fg:#eceff4,hl:#7f8490,fg+:#eceff4,bg+:#3b4252,hl+:#bf616a,info:#bf616a,border:#eceff4,prompt:#bf616a,pointer:#bf616a,marker:#bf616a,spinner:#b48ead,header:#7f8490"
export VIRTUAL_ENV_DISABLE_PROMPT=1

# Cleaning home directory.
export PASSWORD_STORE_DIR="$XDG_DATA_HOME"/pass
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export TEXMFHOME=$XDG_DATA_HOME/texmf
export TEXMFVAR=$XDG_CACHE_HOME/texlive/texmf-var
export TEXMFCONFIG=$XDG_CONFIG_HOME/texlive/texmf-config
export VSCODE_PORTABLE="$XDG_DATA_HOME"/vscode
export PYTHONSTARTUP=$XDG_CONFIG_HOME/python/pythonrc
export MYSQL_HISTFILE="$XDG_DATA_HOME"/mysql_history
export IPYTHONDIR="$XDG_CONFIG_HOME"/jupyter
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME"/jupyter
export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node_repl_history
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
export GOPATH="$XDG_DATA_HOME"/go
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
