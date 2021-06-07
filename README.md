# Dotfiles
This are my personal dotfiles. If you want to clone the whole repository you have to run `git clone --recursive` since every suckless utility is a submodule. If you have already cloned it or just forgot the `--recurse` flag you can run `git submodule update --init` to pull the submodules.

# Table of Contents
* [First some example pictures](#first-some-example-pictures)
* [What are Dotfiles?](#what-are-dotfiles)
* [Dependencies](#dependencies)
* [Essential config files](#essential-config-files)
* [Personal scripts](#personal-scripts)
* [To get things working](#to-get-things-working)
  * [Neovim](#neovim)
  * [Qtile](#qtile)
  * [Firefox](#firefox)

# First some example pictures
*Pictures coming soon!!! For now check the [stored-images](https://github.com/stonefeld/dotfiles/tree/stored-images) branch.*
 
# What are Dotfiles?
*Info coming soon!!!*

# Dependencies
Most of the following packages should be in your distro's repository. In case of arch-users there are some packages that must be installed from the AUR. I recommend install some kind of [AUR helper](https://wiki.archlinux.org/index.php/AUR_helpers). I've been using [paru](https://github.com/Morganamilo/paru) and works really well.
* Essentials:
  * `qtile`
  * `dwm` *(\*)*
  * `alacritty`
  * `st` *(\*)*
  * `dunst`
  * `bash`/`zsh`
  * `neovim` nightly version *(\*\*)*
  * `firefox`
  * `vifm`
  * `pcmanfm`
  * `rofi`
  * `dmenu` *(\*)*
  * `mpd`
  * `ncmpcpp`
  * `picom`
  * `tmux`
  * `xbindkeys`
  * `newsboat`

* Fonts:
  * `adobe-source-code-pro-fonts`
  * `ttf-joypixels`
  * `ttf-fantasque-sans-mono`
  * `ttf-font-icons` *(\*\*)*

* Nerd Fonts:
  * `nerd-fonts-source-code-pro` *(\*\*) (\*\*\*)*
  * `nerd-fonts-fantasque-sans-mono` *(\*\*) (\*\*\*)*

*(\*) = has to be compiled from source*

*(\*\*) = availabe in the AUR*

*(\*\*\*) = could be installed manually from the [nerd-fonts](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts) repository and placed in* `~/.local/share/fonts` *and run* `fc-cache -fv`

# Essential config files
* [Qtile](https://github.com/stonefeld/dotfiles/tree/master/.config/qtile)
* [Dwm](https://github.com/stonefeld/dwm) *(\*)*
* [Neovim](https://github.com/stonefeld/nvim) *(\*)*
* [Alacritty](https://github.com/stonefeld/dotfiles/tree/master/.config/alacritty)
* [St](https://github.com/stonefeld/st) *(\*)*
* [Zsh](https://github.com/stonefeld/dotfiles/tree/master/.config/zsh/.zshrc)
* [Bash](https://github.com/stonefeld/dotfiles/tree/master/.bashrc)
* [Vifm](https://github.com/stonefeld/dotfiles/tree/master/.config/vifm)
* [Rofi](https://github.com/stonefeld/dotfiles/tree/master/.config/rofi)
* [Dmenu](https://github.com/stonefeld/dmenu) *(\*)*

*(\*) = links to another personal repository and is added as a submodule*

# Personal scripts
* [Dwm's statusline](https://github.com/stonefeld/dotfiles/tree/master/.local/bin/statusline)
* [Dmenu and rofi scripts, update checker and others](https://github.com/stonefeld/dotfiles/tree/master/.local/bin)

# To get things working
Here I will give you some basic steps to get things working correctly. First of all you have to make sure that every package from the [dependencies list](#dependencies) is correctly installed and running accordingly.
## Neovim
To get neovim running you need to install a Plugin Manager. My neovim config is prepared for using the [vim-plug](https://github.com/junegunn/vim-plug). To install it on your machine you need to run 
```bash
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```
Then you need to run `:PlugInstall` within neovim after sourcing the [init.vim](https://github.com/stonefeld/nvim/tree/master/init.vim). This will install every package needed to get my neovim configuration, including my self-made vim/neovim colorscheme [nordokai](https://github.com/stonefeld/nordokai), if you want to check it out. ;)

## Qtile
* Just install the following python packages: `iwlib` and `psutil` which are necessary to get network and hardware information.
* Check the [qtile's scripts folder](https://github.com/stonefeld/dotfiles/tree/master/.config/qtile/scripts) to make sure that they are marked as executable. If they are not you can just run `chmod +x ~/.config/qtile/scripts/*`.
* This point is optional, but you need to install and configure [xmenu](https://github.com/phillbush/xmenu) the way you like.

## Firefox
* First you need to locate your *Root Directory* by opening `about:profiles` in Firefox.
* Then create a folder named *chrome* inside the *Root Directory* and place every file in the [firefox configs folder](https://github.com/stonfeld/dotfiles/tree/master/.config/firefox) inside the *chrome* folder.
* Lastly you need to navigate to `about:config` in Firefox and search for `toolkit.legacyUserProfileCustomizations.stylesheets` and set the value to `True`.
