# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set the zinit directory
ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"

# Clone the zinit repository
if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname "$ZINIT_HOME")"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source the zinit script
source "$ZINIT_HOME/zinit.zsh"

# Change zcompdump location
ZSH_COMPDUMP="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump-${(%):-%m}-${ZSH_VERSION}"

# Add powerlevel10k prompt
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add big 3 zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

# FZF integration
zinit light Aloxaf/fzf-tab

# ssh-agent configuration
# zstyle ':omz:plugins:ssh-agent' quiet yes
# zstyle ':omz:plugins:ssh-agent' identities id_github id_bitbucket

# Add snippets
zinit snippet OMZP::archlinux
zinit snippet OMZP::git
# zinit snippet OMZP::git-flow
zinit snippet OMZP::python
# zinit snippet OMZP::ssh-agent
zinit snippet OMZP::systemd

# Load completions
autoload -U compinit && compinit

zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.config/zsh/p10k.zsh ]] || source ~/.config/zsh/p10k.zsh

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# History configuration
HISTSIZE=5000
HISTFILE=~/.cache/zsh/history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# Aliases
if command -v eza &>/dev/null; then
    alias ls='eza --group-directories-first -g'
    alias la='ls -a'
    alias ll='la -l'
fi

alias ip='ip -c'

alias lg='lazygit'

alias v='nvim'
alias vv="[ -f 'Session.vim' ] && nvim -S Session.vim || nvim -c 'Obsession'"
alias v.="nvim ."

alias pys='source .venv/bin/activate'
alias pyd='deactivate'

[ -d "$PWD/.venv" ] && pys

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"
