# Dotfiles

## Installation

```
$ git clone --bare https://github.com/stonefeld/dotfiles $HOME/.local/share/dotfiles
$ alias dotfiles='/usr/bin/git --git-dir=$HOME/.local/share/dotfiles --work-tree=$HOME'
$ dotfiles checkout
```

> **Warning:** This snippet may conflict if any file from the repo already exists.

## Modifying `startx`

When installing `xorg-xinit` in **Arch Linux**, the following command needs to
be executed for `$XINITRC` and `$XSERVERRC` to take effect.

```
# sed -i 's/userclientrc="${XSERVERRC}"/userserverrc="${XSERVERRC}"/' /usr/bin/startx
```
