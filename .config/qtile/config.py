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
from   libqtile        import bar, widget, layout, hook, extension
from   libqtile.config import Click, Drag, Group, Key, Screen, ScratchPad, DropDown
from   libqtile.lazy   import lazy

# Python-scpecific
import os
import re
import socket
import subprocess
from   typing          import List

# Own
from   variables       import *
from   colors          import *
from   keys            import *
from   widgets         import *
from   screens         import *

# Keys
keys = myKeys()

# Groups
group_names = [
    ('WWW',     { 'layout': 'columns' }),
    ('DEV-1',   { 'layout': 'columns' }),
    ('DEV-2',   { 'layout': 'columns' }),
    ('DEV-3',   { 'layout': 'columns' }),
    ('DOC',     { 'layout': 'columns' }),
    ('MUS',     { 'layout': 'columns' }),
    ('CHAT',    { 'layout': 'columns' }),
    ('MAIL',    { 'layout': 'columns' }),
    ('TERM',    { 'layout': 'columns' }),
]

scratchpads = [
    ScratchPad(
        'scratchpad', [
            DropDown('term', myTerm,                                height=0.5, opacity=1, warp_pointer=False),
            DropDown('spt',  f'{myTerm} -e {qtile_scripts}/spt.sh', height=0.8, opacity=1, warp_pointer=False),
            DropDown('mpd',  f'{myTerm} -e {qtile_scripts}/mpd.sh', height=0.8, opacity=1, warp_pointer=False),
            DropDown('mutt', f'{myTerm} -e neomutt',                height=0.8, opacity=1, warp_pointer=False),
            DropDown('htop', f'{myTerm} -e htop',                   height=0.8, opacity=1, warp_pointer=False)
        ]
    )
]

groups = [ Group(name, **kwargs) for name, kwargs in group_names ]
groups.extend(scratchpads)

for i, (name, kwargs) in enumerate(group_names, 1):
    keys.append(Key([mod],          str(i), lazy.group[name].toscreen()))
    keys.append(Key([mod, 'shift'], str(i), lazy.window.togroup(name)))

# Layouts
layout_theme = {
    'border_focus'        : colors_custom[6][0],
    'border_normal'       : colors_standard[0][0],
    'border_focus_stack'  : colors_custom[1][0],
    'border_normal_stack' : colors_standard[0][0],
    'border_width'        : 2,
    'change_size'         : 10,
    'grow_amount'         : 5,
    'margin'              : 6
}

layouts = [
    layout.Columns   (**layout_theme,
                      autosplit        = True,
                      border_on_single = True,
                      insert_position  = 1,
                      num_columns      = 2),
    layout.MonadTall (**layout_theme),
    layout.Tile      (**layout_theme),
    layout.Bsp       (**layout_theme),
    layout.Floating  (**layout_theme),
    layout.Zoomy     (**layout_theme),
    layout.Max       (**layout_theme)
]

widget_defaults = dict(
    font        = 'Fantasque Sans Mono Nerd Font',
    fontsize    = 16,
    padding     = 2,
    background  = colors_standard[1]
)
extension_defaults = widget_defaults.copy()

# Initialize Qtile
if __name__ in ['config', '__main__']:
    screens = myScreen()

# Drag floating layouts.
mouse = [
    Drag([mod], 'Button1', lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], 'Button3', lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], 'Button2', lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules  = []    # type: List
main               = None  # WARNING: this is deprecated and will be removed soon
follow_mouse_focus = True
bring_front_click  = True
cursor_warp        = False

floating_layout_theme = {
    'border_focus' : colors_custom[3][0],
    'border_normal': colors_standard[0][0],
    'border_width' : 2
}

floating_layout = layout.Floating(**floating_layout_theme, float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.

    # Default rules
    { 'role'    : 'pop-up'                },
    { 'wname'   : 'branchdialog'          },
    { 'wname'   : 'pinentry'              },
    { 'wmclass' : 'confirm'               },
    { 'wmclass' : 'confirmreset'          },
    { 'wmclass' : 'dialog'                },
    { 'wmclass' : 'download'              },
    { 'wmclass' : 'error'                 },
    { 'wmclass' : 'file_progress'         },
    { 'wmclass' : 'makebranch'            },
    { 'wmclass' : 'maketag'               },
    { 'wmclass' : 'notification'          },
    { 'wmclass' : 'splash'                },
    { 'wmclass' : 'ssh-askpass'           },
    { 'wmclass' : 'toolbar'               },

    # Own rules
    { 'wname'   : 'Discord Updater'       },
    { 'wmclass' : 'gpicview'              },
    { 'wmclass' : 'lxappearance'          },
    { 'wmclass' : 'lxpolkit'              },
    { 'wmclass' : 'nitrogen'              },
    { 'wmclass' : 'nm-connection-editor'  },
    { 'wmclass' : 'pavucontrol'           },
    { 'wmclass' : 'qutebrowser'           },
    { 'wmclass' : 'system-config-printer' },
    { 'wmclass' : 'xarchiver'             },
    { 'wmclass' : 'Galculator'            },
    { 'wmclass' : 'Leafpad'               },
    { 'wmclass' : 'Msgcompose'            },
    { 'wmclass' : 'Thunar'                },
    { 'wmclass' : 'VirtualBox Manager'    }
])

auto_fullscreen            = True
focus_on_window_activation = 'smart'

@hook.subscribe.startup
def startup():
    subprocess.call([f'{qtile_scripts}/autostart.sh'])

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = 'LG3D'

