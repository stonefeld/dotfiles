# Dotfiles
Theo Stanfield's personal dotfiles.

# Table of Contents
* [Installation](#installation)
* [Example pictures](#example-pictures)
* [Dependencies](#dependencies)
* [Essential config files](#essential-config-files)
* [Personal scripts](#personal-scripts)
* [To get things working](#to-get-things-working)
  * [Neovim](#neovim)
  * [Qtile](#qtile)
  * [Firefox](#firefox)
  * [Suckless software](#suckless-software)

# Installation
I recommend clonning the repository as a git bare repository and locate it in `~/.local/share/dotfiles/`. To do so you have to run:

```bash
$ git clone --bare https://github.com/stonefeld/dotfiles $HOME/.local/share/dotfiles
$ alias dotfiles='/usr/bin/git --git-dir=$HOME/.local/share/dotfiles --work-tree=$HOME'
$ dotfiles checkout
```

Make sure your home directory is completely empty before running it. Otherwise you will get an error.

Another way is to simply clone the repository into a temporary folder and the copy and replace all files on your home directory with the ones on the repo's folder.

There are also links to other git repositories for my custom [dwm](https://github.com/stonefeld/dwm), [st](https://github.com/stonefeld/st) and [dmenu](https://github.com/stonefeld/dmenu) builds and my [neovim setup](https://github.com/stonefeld/nvim). You should clone this respos into their corresponding folders. All this is explained in [To get things working](#to-get-things-working) section.

# Example pictures

### Dwm

![dwm no-color-statusline branch](https://raw.githubusercontent.com/stonefeld/dotfiles/stored-images/screenshot6-1.png)

### Qtile - Option 1

![qtile option 1](https://raw.githubusercontent.com/stonefeld/dotfiles/stored-images/screenshot5-3.png)

### Qtile - Option 2

![qtile option 2](https://raw.githubusercontent.com/stonefeld/dotfiles/stored-images/screenshot5-4.png)

### Qtile - Option 3

![qtile option 3](https://raw.githubusercontent.com/stonefeld/dotfiles/stored-images/screenshot5-5.png)

_This are the most recent pictures from my current setup. For older pictures check the [stored-images](https://github.com/stonefeld/dotfiles/tree/stored-images) branch._

# Dependencies
Most of the following packages should be in your distro's repository. In case of arch-users there are some packages that must be installed from the AUR. I recommend install some kind of [AUR helper](https://wiki.archlinux.org/index.php/AUR_helpers). I've been using [paru](https://github.com/Morganamilo/paru) and works really well.

* Programs with configurations:
  * `alacritty`
  * `bash`
  * `dmenu` _(\*)_
  * `dunst`
  * `dwm` _(\*)_
  * `firefox`
  * `ncmpcpp`
  * `neovim` version 0.5 or above
  * `newsboat`
  * `picom`
  * `qtile`
  * `rofi`
  * `st` _(\*)_
  * `tmux`
  * `vifm`
  * `xbindkeys`
  * `zathura`
  * `zsh`

* Required to get the configurations above working:
  * `brave`
  * `dragon-drag-and-drop` _(\*\*)_
  * `highlight`
  * `fd`
  * `ffmpeg`
  * `fzf`
  * `latex suite`
  * `libxft-bgra` _(\*\*)_
  * `make`
  * `md-to-pdf` by running `npm i -g md-to-pdf`
  * `mpd`
  * `mplayer`
  * `pandoc`
  * `pcmanfm`
  * `python-pygame` or install pygame by running `pip install pygame`
  * `ripgrep`
  * `scrot`
  * `slock`
  * `wireless_tools`
  * `xkb-switch` _(\*\*)_
  * `xmenu`
  * `xss-lock`
  * `zsh-syntax-highlighting` or clone the [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) repository into `$HOME/.config/zsh/zsh-syntax-highlighting/`

* Required fonts:
  * `ttf-cascadia-code`
  * `ttf-fantasque-sans-mono`
  * `ttf-font-icons` _(\*\*)_
  * `ttf-material-design-icons-webfont` _(\*\*)_

* Required nerd-fonts:
  * `nerd-fonts-cascadia-code` _(\*\*) (\*\*\*)_
  * `nerd-fonts-fantasque-sans-mono` _(\*\*) (\*\*\*)_

* Themes:
  * `papirus-folders-git` and configured to use the `nordic` colors _(\*\*)_
  * `papirus-icon-theme`
  * `nordic-theme` _(\*\*)_
  * `xcursor-breeze` _(\*\*)_
_(\*) = has to be compiled from source_

_(\*\*) = availabe in the AUR_

_(\*\*\*) = can be manually installed from the [nerd-fonts](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts) repository and placed in_ `~/.local/share/fonts/` _or_ `/usr/share/fonts/` _and run_ `fc-cache -fv`

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

_(\*) = links to another personal repository and is added as a submodule_

# Personal scripts
* [Dwm's statusline](https://github.com/stonefeld/dotfiles/tree/master/.local/bin/statusline)
* [Dmenu and rofi scripts, update checker and others](https://github.com/stonefeld/dotfiles/tree/master/.local/bin)

# To get things working
Here I will give you some basic steps to get things working correctly. First of all you have to make sure that every package from the [dependencies list](#dependencies) is correctly installed and running accordingly.

## Neovim
First of all, as I explained before, you have to clone the [neovim setup](https://github.com/stonefeld/nvim) repo into `~/.config/nvim`.

Next you need to install a Plugin Manager. My neovim config is prepared for using the [vim-plug](https://github.com/junegunn/vim-plug). To install it on your machine you need to run

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
* First you need to locate your _Root Directory_ by opening `about:profiles` in Firefox.
* Then create a folder named _chrome_ inside the _Root Directory_ and place every file in the [firefox configs folder](https://github.com/stonfeld/dotfiles/tree/master/.config/firefox) inside the _chrome_ folder.
* Lastly you need to navigate to `about:config` in Firefox and search for `toolkit.legacyUserProfileCustomizations.stylesheets` and set the value to `True`.

## Suckless software
As many of you may already know, the suckless utilities have to be compiled to run them, so I created three separated repositories for all three programs I run, which are [dwm](https://github.com/stonefeld/dwm), [st](https://github.com/stonefeld/st) and [dmenu](https://github.com/stonefeld/dmenu). I separated them from this repository since they have their own source files and licences I have to keep attention to.

Now, to get my custom suckless's builds you have to pull every repository into your machine. Usually, repos are located in `~/.local/share/` folder. My recommendation, use which folder location comes handy to you.

Now you simply have to go into the corresponding directory and simply run `sudo make install` on each one of them to install them into your system.
