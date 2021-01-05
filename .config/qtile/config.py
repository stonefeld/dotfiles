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

import os
import re
import socket
import subprocess
import colors
from   libqtile        import bar, widget, layout, hook, extension
from   libqtile.config import Click, Drag, Group, Key, Screen, ScratchPad, DropDown
from   libqtile.lazy   import lazy
from   typing          import List

# Some important variables
mod           = 'mod4'
myTerm        = 'alacritty'
home          = os.path.expanduser('~')
qtile_root    = os.path.join(home, '.config/qtile')
qtile_scripts = os.path.join(qtile_root, 'scripts')

# Colors
colors_inherited = colors.nord()
colors_standard = colors.standard()

keys = [
    # Launch terminal
    Key([mod],            'Return', lazy.spawn(myTerm)),

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

    Key([mod, 'shift'],   'f',      lazy.window.toggle_floating()),
    Key([mod, 'shift'],   'm',      lazy.window.toggle_fullscreen()),

    Key([mod],            'n',      lazy.layout.normalize()),
    Key([mod],            'm',      lazy.layout.maximize()),

    Key([mod, 'mod1'],    'k',      lazy.layout.flip_up()),
    Key([mod, 'mod1'],    'j',      lazy.layout.flip_down()),
    Key([mod, 'mod1'],    'l',      lazy.layout.flip_right()),
    Key([mod, 'mod1'],    'h',      lazy.layout.flip_left()),

    # Open file manager
    Key([mod],            'e',      lazy.spawn('Thunar')),

    # Rofi commands
    Key([mod],            's',      lazy.spawn('rofi -show drun')),
    Key(['mod1'],         'Tab',    lazy.spawn('rofi -show windowcd')),

    # Launch Utilities
    Key([mod],            'r',      lazy.spawn('dmenu_run -b -m eDP1')),
    Key([mod],            'c',      lazy.spawn('galculator')),

    # Playerctl commands  
    Key([mod, 'shift'],   'period', lazy.spawn('playerctl next')),
    Key([mod, 'shift'],   'comma',  lazy.spawn('playerctl previous')),

    # Screenshot
    Key([],               'Print',  lazy.spawn(f'scrot {home}/Pictures/screenshots/screenshot_%Y_%m_%d_%H_%M_%S.png')),

    # DropDown
    Key([mod],            'd',      lazy.group['scratchpad'].dropdown_toggle('term')),
    Key([mod],            'p',      lazy.group['scratchpad'].dropdown_toggle('spt')),
    Key([mod],            'o',      lazy.group['scratchpad'].dropdown_toggle('mpd')),
    Key([mod],            'i',      lazy.group['scratchpad'].dropdown_toggle('mutt')),
    Key([mod],            'u',      lazy.group['scratchpad'].dropdown_toggle('htop')),
]

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

layout_theme = {
    'border_focus':        colors_inherited[6][0],
    'border_normal':       colors_standard[0][0],
    'border_focus_stack':  colors_inherited[1][0],
    'border_normal_stack': colors_standard[0][0],
    'border_width':        2,
    'change_size':         10,
    'grow_amount':         5,
    'margin':              6
}

layouts = [
    layout.Columns   (**layout_theme, border_on_single=True, num_columns=2, autosplit=True, insert_position=1),
    layout.MonadTall (**layout_theme),
    layout.Tile      (**layout_theme),
    layout.Bsp       (**layout_theme),
    layout.Floating  (**layout_theme),
    layout.Zoomy     (**layout_theme),
    layout.Max       (**layout_theme),
]

widget_defaults = dict(
    font        = 'Fantasque Sans Mono Nerd Font',
    fontsize    = 16,
    padding     = 2,
    background  = colors_standard[1]
)
extension_defaults = widget_defaults.copy()

def init_widgets_list():
    widgets_list = [
        widget.TextBox(
            background                  = colors_standard[1],
            fontsize                    = 16,
            foreground                  = colors_inherited[1],
            mouse_callbacks             = {
                'Button1': lambda qtile: qtile.cmd_spawn(f'{qtile_scripts}/xmenu.sh'),
                'Button3': lambda qtile: qtile.cmd_spawn(f'{qtile_scripts}/xmenu.sh')
            },
            padding                     = 10,
            text                        = '\U0000F111 '
        ),
        widget.GroupBox(
            active                      = colors_inherited[7],
            background                  = colors_standard[1],
            borderwidth                 = 4,
            font                        = 'Sans Mono Bold',
            fontsize                    = 12,
            foreground                  = colors_standard[3],
            highlight_color             = colors_standard[2],
            highlight_method            = 'block',
            inactive                    = colors_inherited[8],
            margin_x                    = 0,
            margin_y                    = 3,
            other_current_screen_border = colors_standard[1],
            other_screen_border         = colors_standard[1],
            padding_x                   = 3,
            padding_y                   = 5,
            rounded                     = False,
            this_current_screen_border  = colors_inherited[1],
            this_screen_border          = colors_inherited[13],
            use_mouse_wheel             = False
        ),
        widget.Sep(
            background                  = colors_standard[1],
            linewidth                   = 0,
            padding                     = 20
        ),
        widget.Spacer(bar.STRETCH),
        widget.Sep(
            background                  = colors_standard[1],
            linewidth                   = 0,
            padding                     = 20
        ),
        widget.TextBox(
            background                  = colors_standard[1],
            fontsize                    = 35,
            foreground                  = colors_inherited[1],
            padding                     = 0,
            text                        = '\U0000E0B2'
        ),
        widget.TextBox(
            background                  = colors_inherited[1],
            font                        = 'Icons',
            fontsize                    = 16,
            foreground                  = '#000000',
            mouse_callbacks = {
                'Button1': lambda qtile: qtile.cmd_spawn(myTerm + ' -e htop &'),
                'Button3': lambda qtile: qtile.cmd_spawn('killall htop')
            },
            padding                     = 0,
            text                        = '\U0000F109  '
        ),
        widget.Memory(
            background                  = colors_inherited[1],
            foreground                  = '#000000',
            format                      = 'RAM: {MemPercent}%',
            mouse_callbacks = {
                'Button1': lambda qtile: qtile.cmd_spawn(myTerm + ' -e htop &'),
                'Button3': lambda qtile: qtile.cmd_spawn('killall htop')
            },
            padding                     = 0,
            update_interval             = 1
        ),
        widget.CPU(
            background                  = colors_inherited[1],
            foreground                  = '#000000',
            format                      = ' | CPU: {load_percent}%',
            mouse_callbacks = {
                'Button1': lambda qtile: qtile.cmd_spawn(myTerm + ' -e htop &'),
                'Button3': lambda qtile: qtile.cmd_spawn('killall htop')
            },
            padding                     = 0,
            update_interval             = 1
        ),
        widget.Sep(
            background                  = colors_inherited[1],
            linewidth                   = 0,
            padding                     = 10
        ),
        widget.TextBox(
            background                  = colors_inherited[1],
            fontsize                    = 35,
            foreground                  = colors_inherited[6],
            padding                     = 0,
            text                        = '\U0000E0B2'
        ),
        widget.CurrentLayoutIcon(
            background                  = colors_inherited[6],
            custom_icon_paths           = [ os.path.join(qtile_root, 'icons/') ],
            foreground                  = '#000000',
            padding                     = 0,
            scale                       = 0.6
        ),
        widget.CurrentLayout(
            background                  = colors_inherited[6],
            foreground                  = '#000000',
            padding                     = 0
        ),
        widget.Sep(
            background                  = colors_inherited[6],
            linewidth                   = 0,
            padding                     = 10
        ),
        widget.TextBox(
            background                  = colors_inherited[6],
            fontsize                    = 35,
            foreground                  = colors_inherited[5],
            padding                     = 0,
            text                        = '\U0000E0B2'
        ),
        widget.TextBox(
            background                  = colors_inherited[5],
            font                        = 'Icons',
            fontsize                    = 14,
            foreground                  = '#000000',
            mouse_callbacks = {
                'Button1': lambda qtile: qtile.cmd_spawn('nm-applet'),
                'Button3': lambda qtile: qtile.cmd_spawn('killall nm-applet')
            },
            padding                     = 0,
            text                        = '\U0000F09E  '
        ),
        widget.Wlan(
            background                  = colors_inherited[5],
            foreground                  = '#000000',
            interface                   = 'wlp1s0',
            mouse_callbacks = {
                'Button1': lambda qtile: qtile.cmd_spawn('nm-applet'),
                'Button3': lambda qtile: qtile.cmd_spawn('killall nm-applet')
            },
            padding                    = 0
        ),
        widget.Sep(
            background                 = colors_inherited[5],
            linewidth                  = 0,
            padding                    = 10
        ),
        widget.TextBox(
            background                 = colors_inherited[5],
            fontsize                   = 35,
            foreground                 = colors_inherited[2],
            padding                    = 0,
            text                       = '\U0000E0B2'
        ),
        widget.TextBox(
            background                 = colors_inherited[2],
            font                       = 'Icons',
            fontsize                   = 20,
            foreground                 = '#000000',
            padding                    = 0,
            text                       = '\U0000F2E4'
        ),
        widget.Backlight(
            background                 = colors_inherited[2],
            backlight_name             = 'intel_backlight',
            foreground                 = '#000000',
            format                     = '{percent:2.0%}',
            padding                    = 5
        ),
        widget.TextBox(
            background                 = colors_inherited[2],
            fontsize                   = 16,
            foreground                 = '#000000',
            padding                    = 5,
            text                       = '|'
        ),
        widget.TextBox(
            background                 = colors_inherited[2],
            fontsize                   = 16,
            foreground                 = '#000000',
            padding                    = 5,
            text                       = '\U0000F028 '
        ),
        widget.Volume(
            background                 = colors_inherited[2],
            foreground                 = '#000000',
            volume_app                 = 'alsamixer',
            update_interval            = 0.1
        ),
        widget.TextBox(
            background                 = colors_inherited[2],
            fontsize                   = 16,
            foreground                 = '#000000',
            padding                    = 0,
            text                       = ' | '
        ),
        widget.Battery(
            background                 = colors_inherited[2],
            charge_char                = '\U0000F583',
            discharge_char             = '\U0000F57E',
            empty_char                 = '\U0000F58D',
            foreground                 = '#000000',
            format                     = '{char} {percent:2.0%}',
            fontsize                   = 16,
            full_char                  = '\U0000F578',
            low_percentage             = 0.21,
            padding                    = 0,
            show_short_text            = False,
            update_interval            = 1,
            unknown_char               = '\U0000F590'
        ),
        widget.Sep(
            background                 = colors_inherited[2],
            linewidth                  = 0,
            padding                    = 10
        ),
        widget.TextBox(
            background                 = colors_inherited[2],
            fontsize                   = 35,
            foreground                 = colors_inherited[3],
            padding                    = 0,
            text                       = '\U0000E0B2'
        ),
        widget.TextBox(
            background                 = colors_inherited[3],
            fontsize                   = 16,
            foreground                 = '#000000',
            padding                    = 2,
            text                       = '\U0000F5ED '
        ),
        widget.Clock(
            background                 = colors_inherited[3],
            foreground                 = '#000000',
            format                     = '%a, %b %d - %Y',
            padding                    = 0
        ),
        widget.TextBox(
            background                 = colors_inherited[3],
            fontsize                   = 16,
            foreground                 = '#000000',
            padding                    = 0,
            text                       = ' | '
        ),
        widget.TextBox(
            background                 = colors_inherited[3],
            fontsize                   = 16,
            foreground                 = '#000000',
            padding                    = 0,
            text                       = '\U0000E384 '
        ),
        widget.Clock(
            background                 = colors_inherited[3],
            foreground                 = '#000000',
            format                     = '%H:%M',
            padding                    = 5
        ),
        widget.Sep(
            background                 = colors_inherited[3],
            linewidth                  = 0,
            padding                    = 5
        ),
    ]
    return widgets_list

def init_widgets_screen1():
    widgets_screen1 = init_widgets_list()
    widgets_screen1.append(widget.Systray(
        background = colors_standard[1],
        icon_size  = 20,
        padding    = 2
    ))
    return widgets_screen1

def init_widgets_screen2():
    widgets_screen2 = init_widgets_list()
    widgets_screen2.remove(widgets_screen2[0])
    return widgets_screen2

def init_screens():
    return [
        Screen(top=bar.Bar(widgets=init_widgets_screen1(), opacity=1.0, size=25, margin=6)),
        Screen(top=bar.Bar(widgets=init_widgets_screen2(), opacity=1.0, size=25, margin=6))
    ]

if __name__ in ['config', '__main__']:
    screens = init_screens()

# Drag floating layouts.
mouse = [
    Drag(
        [mod], 'Button1',
        lazy.window.set_position_floating(), start=lazy.window.get_position()
    ),
    Drag(
        [mod], 'Button3',
        lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click(
        [mod], 'Button2',
        lazy.window.bring_to_front()
    )
]

dgroups_key_binder = None
dgroups_app_rules  = []    # type: List
main               = None  # WARNING: this is deprecated and will be removed soon
follow_mouse_focus = True
bring_front_click  = True
cursor_warp        = False

floating_layout = layout.Floating(**layout_theme, float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    { 'role':    'pop-up'                },
    { 'wname':   'branchdialog'          },
    { 'wname':   'pinentry'              },
    { 'wname':   'Discord Updater'       },
    { 'wmclass': 'confirm'               },
    { 'wmclass': 'dialog'                },
    { 'wmclass': 'download'              },
    { 'wmclass': 'error'                 },
    { 'wmclass': 'file_progress'         },
    { 'wmclass': 'notification'          },
    { 'wmclass': 'splash'                },
    { 'wmclass': 'toolbar'               },
    { 'wmclass': 'confirmreset'          },
    { 'wmclass': 'makebranch'            },
    { 'wmclass': 'maketag'               },
    { 'wmclass': 'ssh-askpass'           },
    { 'wmclass': 'VirtualBox Manager'    },
    { 'wmclass': 'lxappearance'          },
    { 'wmclass': 'lxpolkit'              },
    { 'wmclass': 'Thunar'                },
    { 'wmclass': 'pavucontrol'           },
    { 'wmclass': 'Msgcompose'            },
    { 'wmclass': 'nitrogen'              },
    { 'wmclass': 'xarchiver'             },
    { 'wmclass': 'gpicview'              },
    { 'wmclass': 'Leafpad'               },
    { 'wmclass': 'Galculator'            },
    { 'wmclass': 'qutebrowser'           },
    { 'wmclass': 'system-config-printer' },
    { 'wmclass': 'nm-connection-editor'  },
])
auto_fullscreen            = True
focus_on_window_activation = 'smart'

floating_types = [
    'notification', 'toolbar', 'splash', 'dialog', 'utility',
    'menu', 'dropdown_menu', 'popup_menu', 'tooltip' ,'dock',
]

@hook.subscribe.client_new
def set_floating(window):
    if (window.window.get_wm_transient_for() or window.window.get_wm_type() in floating_types):
        window.floating = True

@hook.subscribe.client_new
def floating_dialogs(window):
    dialog = window.window.get_wm_type() == 'dialog'
    transient = window.window.get_wm_transient_for()
    if dialog or transient:
        window.floating = True

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

