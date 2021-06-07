# Dotfiles
This are my personal dotfiles. If you want to clone the whole repository you have to run <code>git clone --recursive</code> since every suckless utility is a submodule. If you have already cloned it or just forgot the <code>--recurse</code> flag you can run <code>git submodule update --init</code> to pull the submodules.

# Table of Contents
* [First some example pictures](#example-pics)
* [What are Dotfiles?](#what-dotfiles)
* [Dependencies](#dependencies)
* [Essential config files](#config-files)
* [Personal scripts](#personal-scripts)
* [To get things working](#get-things-working)
  * [Neovim](#neovim-working)
  * [Qtile](#qtile-working)
  * [Firefox](#firefox-working)

# First some example pictures <a name="example-pics"></a>
<i>Pictures coming soon!!! For now check the [stored-images](https://github.com/stonefeld/dotfiles/tree/stored-images) branch.</i>
 
# What are Dotfiles? <a name="what-dotfiles"></a>
<i>Info coming soon!!!</i>

# Dependencies <a name="dependencies"></a>
Most of the following packages should be in your distro's repository. In case of arch-users there are some packages that must be installed from the AUR. I recommend install some kind of [AUR helper](https://wiki.archlinux.org/index.php/AUR_helpers). I've been using [paru](https://github.com/Morganamilo/paru) and works really well.
* Essentials:
  * `qtile`
  * `dwm` <i>(\*)</i>
  * `alacritty`
  * `st` <i>(\*)</i>
  * `dunst`
  * `bash`/`zsh`
  * `neovim` nightly version <i>(\*\*)</i>
  * `firefox`
  * `vifm`
  * `rofi`
  * `dmenu` <i>(\*)</i>
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
  * `ttf-font-icons` <i>(\*\*)</i>

* Nerd Fonts:
  * `nerd-fonts-source-code-pro` <i>(\*\*) (\*\*\*)</i>
  * `nerd-fonts-fantasque-sans-mono` <i>(\*\*) (\*\*\*)</i>

<i>(\*) = has to be compiled from source</i><br>
<i>(\*\*) = availabe in the AUR</i><br>
<i>(\*\*\*) = could be installed manually from the [nerd-fonts](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts) repository and placed in</i> `~/.local/share/fonts` <i>and run</i> `fc-cache -fv`</i>

# Essential config files <a name="config-files"></a>
* [Qtile](https://github.com/stonefeld/dotfiles/tree/master/.config/qtile)
* [Dwm](https://github.com/stonefeld/dwm) <i>(\*)</i>
* [Neovim](https://github.com/stonefeld/nvim) <i>(\*)</i>
* [Alacritty](https://github.com/stonefeld/dotfiles/tree/master/.config/alacritty)
* [St](https://github.com/stonefeld/st) <i>(\*)</i>
* [Zsh](https://github.com/stonefeld/dotfiles/tree/master/.config/zsh/.zshrc)
* [Bash](https://github.com/stonefeld/dotfiles/tree/master/.bashrc)
* [Vifm](https://github.com/stonefeld/dotfiles/tree/master/.config/vifm)
* [Rofi](https://github.com/stonefeld/dotfiles/tree/master/.config/rofi)
* [Dmenu](https://github.com/stonefeld/dmenu) <i>(\*)</i>

<i>(\*) = links to another personal repository and is added as a submodule</i>

# Personal scripts <a name="personal-scripts"></a>
* [Dwm's statusline](https://github.com/stonefeld/dotfiles/tree/master/.local/bin/statusline)
* [Dmenu and rofi scripts, update checker and others](https://github.com/stonefeld/dotfiles/tree/master/.local/bin)

# To get things working <a name="get-things-working"></a>
Here I will give you some basic steps to get things working correctly. First of all you have to make sure that every package from the [dependencies list](#dependencies) is correctly installed and running accordingly.
## Neovim <a name="neovim-working"></a>
To get neovim running you need to install a Plugin Manager. My neovim config is prepared for using the [vim-plug](https://github.com/junegunn/vim-plug). To install it on your machine you need to run 
```bash
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```
Then you need to run `:PlugInstall` within neovim after sourcing the [init.vim](https://github.com/stonefeld/nvim/tree/master/init.vim). This will install every package needed to get my neovim configuration, including my self-made vim/neovim colorscheme [nordokai](https://github.com/stonefeld/nordokai), if you want to check it out. ;)

## Qtile <a name="qtile-working"></a>
* Just install the following python packages: `iwlib` and `psutil` which are necessary to get network and hardware information.
* Check the [qtile's scripts folder](https://github.com/stonefeld/dotfiles/tree/master/.config/qtile/scripts) to make sure that they are marked as executable. If they are not you can just run `chmod +x ~/.config/qtile/scripts/*`.
* This point is optional, but you need to install and configure [xmenu](https://github.com/phillbush/xmenu) the way you like.

## Firefox <a name="firefox-working"></a>
* First you need to locate your <i>Root Directory</i> by opening `about:profiles` in Firefox.
* Then create a folder named <i>chrome</i> inside the <i>Root Directory</i> and place every file in the [firefox configs folder](https://github.com/stonfeld/dotfiles/tree/master/.config/firefox) inside the <i>chrome</i> folder.
* Lastly you need to navigate to `about:config` in Firefox and search for `toolkit.legacyUserProfileCustomizations.stylesheets` and set the value to `True`.
