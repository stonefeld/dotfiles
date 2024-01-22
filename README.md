# Dotfiles

## Installation

> You need `stow` installed for this to work

Simply run the following command for each component you want to have

```bash
stow -t $HOME <component>

# For example, to copy the zsh configs
stow -t $HOME zsh

# To get all configs run
find . -maxdepth 1 -type d ! -path '*/.*' ! -path '.' | xargs -n1 stow -t $HOME
```

To understand more about `stow` read the [official page documentation](https://www.gnu.org/software/stow/manual/stow.html)

## Modifying `startx`

When installing `xorg-xinit` in **Arch Linux**, the following command needs to
be executed for `$XINITRC` and `$XSERVERRC` to take effect (**as superuser**).

```bash
sed -i 's/userclientrc="${XSERVERRC}"/userserverrc="${XSERVERRC}"/' /usr/bin/startx
```
