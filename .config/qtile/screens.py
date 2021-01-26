# 
#  ██████╗ ████████╗██╗██╗     ███████╗
# ██╔═══██╗╚══██╔══╝██║██║     ██╔════╝
# ██║   ██║   ██║   ██║██║     █████╗  
# ██║▄▄ ██║   ██║   ██║██║     ██╔══╝  
# ╚██████╔╝   ██║   ██║███████╗███████╗
#  ╚══▀▀═╝    ╚═╝   ╚═╝╚══════╝╚══════╝
#                                      
# Author: Theo Stanfield
# Date: 23/09/2020
# Git: https://github.com/TheoStanfield/dotfiles.git
#

# LibQtile
from libqtile        import bar, widget
from libqtile.config import Screen

# Own
from colors          import *
from widgets         import *

def myScreenMain():
    screen_main = myWidgets()
    screen_main.append(widget.Systray(
        background = colors_standard[1],
        icon_size  = 20,
        padding    = 2
    ))
    return screen_main

def myScreenSecondary():
    screen_secondary = myWidgets()
    screen_secondary.remove(screen_secondary[0])
    return screen_secondary

def myScreen():
    return [
        Screen(top=bar.Bar(widgets=myScreenMain(),      opacity=1.0, size=25, margin=6)),
        Screen(top=bar.Bar(widgets=myScreenSecondary(), opacity=1.0, size=25, margin=6))
    ]

