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

## Getting `zsh` config to work

```
$ sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
$ git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
$ git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```
