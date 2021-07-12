# Dotfiles
This are my personal dotfiles. If you want to clone the whole repository you have to run `git clone --recursive` since every suckless utility is a submodule. If you have already cloned it or just forgot the `--recurse` flag, to pull the submodules, you can run `git submodule update --init`.

# Table of Contents
* [Example pictures](#example-pictures)
* [Dependencies](#dependencies)
* [Essential config files](#essential-config-files)
* [Personal scripts](#personal-scripts)
* [To get things working](#to-get-things-working)
  * [Neovim](#neovim)
  * [Qtile](#qtile)
  * [Firefox](#firefox)
  * [Suckless software](#suckless-software)

# Example pictures

### Qtile - Option 1

![qtile option 1](https://raw.githubusercontent.com/stonefeld/dotfiles/stored-images/screenshot5-3.png)

### Qtile - Option 2

![qtile option 2](https://raw.githubusercontent.com/stonefeld/dotfiles/stored-images/screenshot5-4.png)

### Qtile - Option 3

![qtile option 3](https://raw.githubusercontent.com/stonefeld/dotfiles/stored-images/screenshot5-5.png)

### Dwm - No color emojis statusline

![dwm no color statusline](https://raw.githubusercontent.com/stonefeld/dotfiles/stored-images/screenshot5-1.png)

### Dwm - Colored emojis statusline

![dwm colored statusline](https://raw.githubusercontent.com/stonefeld/dotfiles/stored-images/screenshot5-2.png)

*This are the most recent pictures from my current setup. For older pictures check the [stored-images](https://github.com/stonefeld/dotfiles/tree/stored-images) branch.*

# Dependencies
Most of the following packages should be in your distro's repository. In case of arch-users there are some packages that must be installed from the AUR. I recommend install some kind of [AUR helper](https://wiki.archlinux.org/index.php/AUR_helpers). I've been using [paru](https://github.com/Morganamilo/paru) and works really well.

* Essentials:
  * `qtile`
  * `dwm` *(\*)*
  * `alacritty`
  * `st` *(\*)*
  * `dunst`
  * `bash`/`zsh`
  * `neovim` version 0.5 or above
  * `firefox`
  * `brave`
  * `qutebrowser`
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
  * `xmenu`

* Tools:
  * `make`
  * `fzf`
  * `ripgrep`
  * `fd`
  * `latex suite`
  * `pandoc`
  * `scrot`

* Fonts:
  * `adobe-source-code-pro-fonts`
  * `ttf-joypixels`
  * `ttf-fantasque-sans-mono`
  * `ttf-fira-code`
  * `ttf-font-icons` *(\*\*)*

* Nerd Fonts:
  * `nerd-fonts-source-code-pro` *(\*\*) (\*\*\*)*
  * `nerd-fonts-fantasque-sans-mono` *(\*\*) (\*\*\*)*

* Themes:
  * `nordic-theme` *(\*\*)*
  * `papirus-icon-theme`
  * `papirus-folders-git` and configured to use the `nordic` colors *(\*\*)*

*(\*) = has to be compiled from source*

*(\*\*) = availabe in the AUR*

*(\*\*\*) = can be manually installed from the [nerd-fonts](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts) repository and placed in* `~/.local/share/fonts` *or* `/usr/share/fonts` *and run* `fc-cache -fv`

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

## Suckless software
As many of you may already know, the suckless utilities have to be compiled to run them, so I created three separated repositories for all three programs I run, which are [dwm](https://github.com/stonefeld/dwm), [st](https://github.com/stonefeld/st) and [dmenu](https://github.com/stonefeld/dmenu). I separated them from this repository since they have their own source files and licences I have to keep attention to.

Now, to get my customized suckless's utilities you have to pull every repository into your machine. If you have already run `git clone --recursive` you won't have to do this, because this programs are added as submodules from the current repository and they will be located in the `~/.local/share/` folder.

Now you simply have to go into the corresponding directory and simply run `sudo make install` on each one of them to install them into your system.
