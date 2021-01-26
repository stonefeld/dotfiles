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

# Python-scpecific
import os

# ModKey set to Super
mod           = 'mod4'

# Terminal of choice
myTerm        = 'alacritty'

# Some relevant paths
home          = os.path.expanduser('~')
qtile_root    = os.path.join(home, '.config/qtile')
qtile_scripts = os.path.join(qtile_root, 'scripts')