# DotFiles

Welcome to my dotfiles. In this GitHub repository you will find configuration files for:
* <code>alacritty</code> terminal emulator
* <code>qtile</code> window manager
* <code>bash</code>, <code>zsh</code> and <code>fish</code> shells
* <code>firefox</code> web browser
* <code>neovim</code> text editor
* <code>rofi</code> app launcher
* <code>dunst</code> notification service daemon

In addition I have written and pushed some other files like the configuration file for the <code>picom</code> compositor, <code>postswitch</code> and <code>preswitch</code> scripts for the <code>autorandr</code> utility, a bash script that checks for <code>pacman udpates</code> and is invoked with a <code>system timer unit</code>, among other files.

In the next picture there's a small recopilation of the visual aspect from my desktop environment and the applications I'm using.

![](https://github.com/TheoStanfield/dotfiles/blob/stored-images/screenshot4.png)

### **General Recommendation**
Before trying this files out, there are many points to take into consideration:
* First of all, you will need to install the following fonts:
  * <code>nerd-fonts-fantasque-sans-mono</code> in the [AUR](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/FantasqueSansMono)
  * <code>ttf-fantasque-sans-mono</code>
  * <code>ttf-font-icons</code> in the AUR
  * <code>ttf-ubuntu-font-family</code>
  
*Font families are listed in relevance and usage order. Many of this fonts are not available in the official package respositories from Arch Linux, so you may need to use the [AUR](https://wiki.archlinux.org/index.php/AUR_helpers). I've been using [paru](https://github.com/Morganamilo/paru) in the last time.*

*There is also the alternative of downloading the* <code>.ttf</code> *from GitHub and locate them in* <code>~/.local/share/fonts</code> *folder instead of installing them with the package manager.*

* To get NeoVim running:
  * You firstly need to install a Plugin Manager. My NeoVim config is prepared for using the [vim-plug](https://github.com/junegunn/vim-plug). To install it on your machine you need to run 
    ```bash
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
      ```
  * Then you need to run <code>:PlugInstall</code> within NeoVim after running <code>:w</code> and <code>:source %</code> in the NeoVim config file
* To get Qtile running:
  * There are some Python modules required to get Qtile running that are listed in the [Qtile Documentation](http://docs.qtile.org/en/latest/) which is very well explained. The packages are mentioned in every **widget** section so you may need to explore the documentation to find out which modules are required.
  * Also you may need to install [xmenu](https://github.com/phillbush/xmenu).
* To get Alacritty running you just need to install **Alacritty** from your package manager and the configuration file will be loaded automatically since it's located in the default location.
* To get Bash running you need to install some packages from  your package manager to get every <code>.bashrc</code> feature working:
  * <code>Git</code>
  * <code>exa</code>
* Lastly, to get Rofi running you may need to install [rofi-calc](https://github.com/svenstaro/rofi-calc) from your package manager.

I hope you enjoy it and if you have any suggestion I'd likely to hear them :D
