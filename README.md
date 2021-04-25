# DotFiles

### **First of all**
To clone this whole repository you have to run <code>git clone --recursive</code> since every suckless utility present in this repo is added as a submodule. If you have already cloned it without the <code>--recursive</code> flag you can run <code>git submodule update --init</code> to pull every submodule at once.

Welcome to my dotfiles. In this GitHub repository you will find configuration files for:
* <code>alacritty</code> terminal emulator
* <code>st</code> terminal emulator
* <code>qtile</code> window manager
* <code>dwm</code> window manager
* <code>bash</code> and <code>zsh</code> shells
* <code>firefox</code> web browser
* <code>neovim</code> text editor
* <code>rofi</code> app launcher
* <code>dwm</code> app launcher
* <code>dunst</code> notification service daemon

In addition I have written and pushed some other files like the configuration file for the <code>picom</code> compositor, a shell script that checks for <code>pacman udpates</code> and is invoked with a <code>system timer unit</code>, among other files.

In the next picture there's a small recopilation of the visual aspect from my desktop environment and the applications I'm using.

![](https://github.com/stonefeld/dotfiles/blob/stored-images/screenshot4.png)

### **General Recommendation**
Before trying this files out, there are many points to take into consideration:
* First of all, you will need to install every package mentioned and the following fonts:
  * <code>nerd-fonts-fantasque-sans-mono</code> available in the [AUR](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/FantasqueSansMono)
  * <code>ttf-fantasque-sans-mono</code>
  * <code>ttf-font-icons</code> available in the AUR
  * <code>ttf-ubuntu-font-family</code>
  
*Font families are listed in relevance and usage order. Many of this fonts are not available in the official package respositories from Arch Linux, so you may need to use an [AUR helper](https://wiki.archlinux.org/index.php/AUR_helpers). I've been using [paru](https://github.com/Morganamilo/paru) in the last time.*

*There is also the alternative of downloading the* <code>.ttf</code> *from GitHub and locate them in* <code>~/.local/share/fonts</code> *folder and then running* <code>fc-cache</code> *instead of installing them with the package manager.*

* To get **Qtile** running:
  * You will need the following python packages: <code>iwlib</code> <code>psutil</code>
  * Except for that everything else should work out of the box. The only one thing I recommend doing is checking that every bash script in the [scripts folder](https://github.com/stonefeld/dotfiles/tree/master/.config/qtile/scripts) have execution permission by running <code>sudo chmod +x ~/.config/qtile/scripts/*</code> .
    * There are some bash scripts that are meant for laptops such as the <code>[touchpad.sh](https://github.com/stonefeld/dotfiles/blob/master/.config/qtile/scripts/touchpad.sh)</code> and <code>[touchscreen.sh](https://github.com/stonefeld/dotfiles/blob/master/.config/qtile/scripts/touchscreen.sh)</code>. You are free to remove them if you like.
  * Also you may need to install [xmenu](https://github.com/phillbush/xmenu).
* To get **NeoVim** running:
  * You firstly need to install a Plugin Manager. My NeoVim config is prepared for using the [vim-plug](https://github.com/junegunn/vim-plug). To install it on your machine you need to run 
    ```bash
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
      ```
  * Then you need to run <code>:PlugInstall</code> within NeoVim after running <code>:w</code> and <code>:source %</code> in the NeoVim config file
* To get **Alacritty** running you just need to install <code>alacritty</code> from your package manager and the configuration file will be automatically loaded.
* To get **Firefox** running:
  * First you need to locate your **Root Directory** by opening <code>about:profiles</code> in Firefox
  * Then create a folder named **chrome** inside the **Root Directory** and place every file in the [firefox config folder](https://github.com/TheoStanfield/dotfiles/tree/master/.config/firefox) inside that folder
  * Lastly you need to navigate to <code>about:config</code> in Firefox and after accepting every warning, search for <code>toolkit.legacyUserProfileCustomizations.stylesheets</code> and set its value to <code>True</code>
  * Finally restart Firefox

I hope you enjoy it and if you have any suggestion I'd likely to hear them :D
