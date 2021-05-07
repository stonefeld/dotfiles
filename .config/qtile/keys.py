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
from   libqtile        import extension
from   libqtile.config import Key
from   libqtile.lazy   import lazy

# Own
from   variables       import *

def my_keys():
    return [
        # Launch terminal
        Key([mod],            'Return', lazy.spawn(f'{my_term} -e zsh')),

        # Toggle between different layouts as defined below
        Key([mod],            'Tab',    lazy.next_layout()),
        Key([mod, 'shift'],   'Tab',    lazy.prev_layout()),

        # Kill a window
        Key([mod, 'shift'],   'w',      lazy.window.kill()),

        # Kill and restart qtile
        Key([mod, 'control'], 'q',      lazy.shutdown()),
        Key([mod, 'control'], 'r',      lazy.restart()),

        # Switch keyboard focus from monitors
        Key([mod],            'q',      lazy.to_screen(1)),
        Key([mod],            'w',      lazy.to_screen(0)),
        Key([mod],            'period', lazy.next_screen()),
        Key([mod],            'comma',  lazy.prev_screen()),

        # Switch window focus to other pane(s) of stack
        Key([mod],            'space',  lazy.layout.next()),

        # Switch between windows in current stack pane
        Key([mod],            'j',      lazy.layout.down()),
        Key([mod],            'k',      lazy.layout.up()),
        Key([mod],            'l',      lazy.layout.right()),
        Key([mod],            'h',      lazy.layout.left()),
        Key([mod],            'Up',     lazy.window.bring_to_front()),
        Key([mod],            'Down',   lazy.window.toggle_minimize()),

        # Move windows in pane
        Key([mod, 'shift'],   'j',      lazy.layout.shuffle_down()),
        Key([mod, 'shift'],   'k',      lazy.layout.shuffle_up()),
        Key([mod, 'shift'],   'l',      lazy.layout.shuffle_right()),
        Key([mod, 'shift'],   'h',      lazy.layout.shuffle_left()),

        # Swap panes of split stack
        Key([mod, 'shift'],   'space',  lazy.layout.rotate(), lazy.layout.flip()),
        Key([mod, 'shift'],   'Return', lazy.layout.toggle_split()),

        # Window size controls
        Key([mod, 'control'], 'l',      lazy.layout.grow_right(), lazy.layout.grow(), lazy.layout.increase_ratio(), lazy.layout.delete()),
        Key([mod, 'control'], 'h',      lazy.layout.grow_left(), lazy.layout.shrink(), lazy.layout.decrease_ratio(), lazy.layout.add()),
        Key([mod, 'control'], 'k',      lazy.layout.grow_up(), lazy.layout.grow(), lazy.layout.decrease_nmaster()),
        Key([mod, 'control'], 'j',      lazy.layout.grow_down(), lazy.layout.shrink(), lazy.layout.increase_nmaster()),

        # Toggle fullscreen and floating
        Key([mod, 'shift'],   'f',      lazy.window.toggle_floating()),
        Key([mod, 'shift'],   'm',      lazy.window.toggle_fullscreen()),

        # Toggle maximized and normalize pane sizes
        Key([mod],            'm',      lazy.window.toggle_maximize()),
        Key([mod],            'n',      lazy.layout.normalize()),

        # Open file manager
        Key([mod],            'e',      lazy.spawn(my_filemanager)),

        # Rofi commands
        Key([mod],            's',      lazy.spawn('rofi -show drun')),
        Key(['mod1'],         'Tab',    lazy.spawn('rofi -show windowcd')),

        # Launch Utilities
        Key([mod],            'r',      lazy.spawncmd()),
        Key([mod],            'p',      lazy.spawn('dmenu_run -c -l 20 -bw 2')),
        Key([mod],            'c',      lazy.spawn('galculator')),

        # Playerctl commands  
        Key([mod, 'shift'],   'period', lazy.spawn('playerctl next')),
        Key([mod, 'shift'],   'comma',  lazy.spawn('playerctl previous')),

        # Screenshot
        Key([],               'Print',  lazy.spawn(f'{qtile_scripts}/scrot.sh')),
        Key(['shift'],        'Print',  lazy.spawn(f'{qtile_scripts}/scrot.sh 5')),

        # DropDown
        Key([mod],            'd',      lazy.group['scratchpad'].dropdown_toggle('term')),
        Key([mod],            'o',      lazy.group['scratchpad'].dropdown_toggle('mpd')),
        Key([mod],            'i',      lazy.group['scratchpad'].dropdown_toggle('mutt')),
        Key([mod],            'u',      lazy.group['scratchpad'].dropdown_toggle('top')),

        # Disable Touchpad
        Key(['shift'],        'F6',     lazy.spawn(f'{qtile_scripts}/touchpad.sh')),

        # Activate password manager
        Key([mod, 'shift'],   'p',      lazy.spawn('passmenu -b -p "Password Store"'))
    ]
