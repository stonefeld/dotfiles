# Dotfiles

## Installation

```bash
$ git clone --bare https://github.com/stonefeld/dotfiles $HOME/.local/share/dotfiles
$ alias dotfiles='/usr/bin/git --git-dir=$HOME/.local/share/dotfiles --work-tree=$HOME'
$ dotfiles checkout
```

> **Warning:** This snippet may conflict if any file from the repo already exists.
