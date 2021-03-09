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
from   libqtile  import bar, widget, qtile

# Python-scpecific
import os

# Own
from   variables import *
from   colors    import *

def nm_applet():
    qtile.cmd_spawn(f'{qtile_scripts}/openfiles.sh 1')

def close_nm_applet():
    qtile.cmd_spawn(f'{qtile_scripts}/openfiles.sh 2')

def open_htop():
    qtile.cmd_spawn(f'{qtile_scripts}/openfiles.sh 3')

def close_htop():
    qtile.cmd_spawn(f'{qtile_scripts}/openfiles.sh 4')

def xmenu():
    qtile.cmd_spawn(f'{qtile_scripts}/xmenu.sh')

def myWidgets():
    return [
        widget.TextBox(
            background                  = colors_standard[1],
            fontsize                    = 16,
            foreground                  = colors_custom[1],
            mouse_callbacks             = {
                'Button1': xmenu,
                'Button3': xmenu
            },
            padding                     = 10,
            text                        = '\U0000F111 '
        ),
        widget.GroupBox(
            active                      = colors_custom[7],
            background                  = colors_standard[1],
            borderwidth                 = 4,
            font                        = 'Sans Mono Bold',
            fontsize                    = 12,
            foreground                  = colors_standard[3],
            highlight_color             = colors_standard[2],
            highlight_method            = 'block',
            inactive                    = colors_custom[8],
            margin_x                    = 0,
            margin_y                    = 3,
            other_current_screen_border = colors_standard[1],
            other_screen_border         = colors_standard[1],
            padding_x                   = 3,
            padding_y                   = 5,
            rounded                     = False,
            this_current_screen_border  = colors_custom[1],
            this_screen_border          = colors_custom[13],
            use_mouse_wheel             = False
        ),
        widget.Sep(
            background                  = colors_standard[1],
            linewidth                   = 0,
            padding                     = 20
        ),
        widget.Prompt(
            font                        = 'SourceCodePro',
            fontsize                    = 16,
            foreground                  = colors_custom[7],
            prompt                      = ': '
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
            foreground                  = colors_custom[1],
            padding                     = 0,
            text                        = '\U0000E0B2'
        ),
        widget.TextBox(
            background                  = colors_custom[1],
            font                        = 'Icons',
            fontsize                    = 16,
            foreground                  = '#000000',
            mouse_callbacks = {
                'Button1': open_htop,
                'Button3': close_htop
            },
            padding                     = 0,
            text                        = '\U0000F109  '
        ),
        widget.Memory(
            background                  = colors_custom[1],
            foreground                  = '#000000',
            format                      = 'RAM: {MemPercent}%',
            mouse_callbacks = {
                'Button1': open_htop,
                'Button3': close_htop
            },
            padding                     = 0,
            update_interval             = 1
        ),
        widget.CPU(
            background                  = colors_custom[1],
            foreground                  = '#000000',
            format                      = ' | CPU: {load_percent}%',
            mouse_callbacks = {
                'Button1': open_htop,
                'Button3': close_htop
            },
            padding                     = 0,
            update_interval             = 1
        ),
        widget.Sep(
            background                  = colors_custom[1],
            linewidth                   = 0,
            padding                     = 10
        ),
        widget.TextBox(
            background                  = colors_custom[1],
            fontsize                    = 35,
            foreground                  = colors_custom[6],
            padding                     = 0,
            text                        = '\U0000E0B2'
        ),
        widget.CurrentLayoutIcon(
            background                  = colors_custom[6],
            custom_icon_paths           = [ os.path.join(qtile_root, 'icons/') ],
            foreground                  = '#000000',
            padding                     = 0,
            scale                       = 0.6
        ),
        widget.CurrentLayout(
            background                  = colors_custom[6],
            foreground                  = '#000000',
            padding                     = 0
        ),
        widget.Sep(
            background                  = colors_custom[6],
            linewidth                   = 0,
            padding                     = 10
        ),
        widget.TextBox(
            background                  = colors_custom[6],
            fontsize                    = 35,
            foreground                  = colors_custom[5],
            padding                     = 0,
            text                        = '\U0000E0B2'
        ),
        widget.TextBox(
            background                  = colors_custom[5],
            font                        = 'Icons',
            fontsize                    = 14,
            foreground                  = '#000000',
            mouse_callbacks = {
                'Button1': nm_applet,
                'Button3': close_nm_applet,
            },
            padding                     = 0,
            text                        = '\U0000F09E  '
        ),
        widget.Wlan(
            background                  = colors_custom[5],
            foreground                  = '#000000',
            interface                   = 'wlp1s0',
            mouse_callbacks = {
                'Button1': nm_applet,
                'Button3': close_nm_applet,
            },
            padding                    = 0
        ),
        widget.Sep(
            background                 = colors_custom[5],
            linewidth                  = 0,
            padding                    = 10
        ),
        widget.TextBox(
            background                 = colors_custom[5],
            fontsize                   = 35,
            foreground                 = colors_custom[2],
            padding                    = 0,
            text                       = '\U0000E0B2'
        ),
        widget.TextBox(
            background                 = colors_custom[2],
            font                       = 'Icons',
            fontsize                   = 20,
            foreground                 = '#000000',
            padding                    = 0,
            text                       = '\U0000F2E4'
        ),
        widget.Backlight(
            background                 = colors_custom[2],
            backlight_name             = 'intel_backlight',
            foreground                 = '#000000',
            format                     = '{percent:2.0%}',
            padding                    = 5
        ),
        widget.TextBox(
            background                 = colors_custom[2],
            fontsize                   = 16,
            foreground                 = '#000000',
            padding                    = 5,
            text                       = '|'
        ),
        widget.TextBox(
            background                 = colors_custom[2],
            fontsize                   = 16,
            foreground                 = '#000000',
            padding                    = 5,
            text                       = '\U0000F028 '
        ),
        widget.Volume(
            background                 = colors_custom[2],
            foreground                 = '#000000',
            volume_app                 = 'alsamixer',
            update_interval            = 0.1
        ),
        widget.TextBox(
            background                 = colors_custom[2],
            fontsize                   = 16,
            foreground                 = '#000000',
            padding                    = 0,
            text                       = ' | '
        ),
        widget.Battery(
            background                 = colors_custom[2],
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
            background                 = colors_custom[2],
            linewidth                  = 0,
            padding                    = 10
        ),
        widget.TextBox(
            background                 = colors_custom[2],
            fontsize                   = 35,
            foreground                 = colors_custom[3],
            padding                    = 0,
            text                       = '\U0000E0B2'
        ),
        widget.TextBox(
            background                 = colors_custom[3],
            fontsize                   = 16,
            foreground                 = '#000000',
            padding                    = 2,
            text                       = '\U0000F5ED '
        ),
        widget.Clock(
            background                 = colors_custom[3],
            foreground                 = '#000000',
            format                     = '%a, %b %d - %Y',
            padding                    = 0
        ),
        widget.TextBox(
            background                 = colors_custom[3],
            fontsize                   = 16,
            foreground                 = '#000000',
            padding                    = 0,
            text                       = ' | '
        ),
        widget.TextBox(
            background                 = colors_custom[3],
            fontsize                   = 16,
            foreground                 = '#000000',
            padding                    = 0,
            text                       = '\U0000E384 '
        ),
        widget.Clock(
            background                 = colors_custom[3],
            foreground                 = '#000000',
            format                     = '%H:%M',
            padding                    = 5
        ),
        widget.Sep(
            background                 = colors_custom[3],
            linewidth                  = 0,
            padding                    = 5
        ),
    ]

