# LibQtile
from   libqtile  import bar, widget, qtile

# Python-scpecific
import os

# Own
from   variables import *
from   colors    import *

def nm_applet():
    qtile.cmd_spawn('nm-applet')

def close_nm_applet():
    qtile.cmd_spawn('killall nm-applet')

def xmenu():
    qtile.cmd_spawn('xmenurun')

def my_sep(b=colors_standard[1], p=20):
    return widget.Sep(background=b, linewidth=0, padding=p)

def my_widgets():
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
            this_current_screen_border  = colors_custom[9],
            this_screen_border          = colors_custom[13],
            use_mouse_wheel             = False
        ),
        my_sep(),
        widget.Prompt(
            font                        = 'SourceCodePro',
            fontsize                    = 16,
            foreground                  = colors_custom[7],
            prompt                      = ': '
        ),
        widget.Spacer(bar.STRETCH),
        my_sep(),
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
            padding                     = 0,
            text                        = '\U0000F109  '
        ),
        widget.Memory(
            background                  = colors_custom[1],
            foreground                  = '#000000',
            format                      = 'RAM: {MemPercent}%',
            padding                     = 0,
            update_interval             = 1
        ),
        widget.CPU(
            background                  = colors_custom[1],
            foreground                  = '#000000',
            format                      = ' | CPU: {load_percent}%',
            padding                     = 0,
            update_interval             = 1
        ),
        my_sep(b=colors_custom[1], p=15),
        widget.TextBox(
            background                  = colors_custom[1],
            fontsize                    = 35,
            foreground                  = colors_custom[6],
            padding                     = 0,
            text                        = '\U0000E0B2'
        ),
        widget.CurrentLayoutIcon(
            background                  = colors_custom[6],
            custom_icon_paths           = [ os.path.join(qtile_root, 'icons_black_outline/') ],
            foreground                  = '#000000',
            padding                     = 0,
            scale                       = 0.5
        ),
        widget.CurrentLayout(
            background                  = colors_custom[6],
            foreground                  = '#000000',
            padding                     = 2
        ),
        my_sep(b=colors_custom[6], p=10),
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
            format                      = '{essid}',
            interface                   = 'wlp1s0',
            mouse_callbacks = {
                'Button1': nm_applet,
                'Button3': close_nm_applet,
            },
            padding                     = 0
        ),
        my_sep(b=colors_custom[5], p=10),
        widget.TextBox(
            background                  = colors_custom[5],
            fontsize                    = 35,
            foreground                  = colors_custom[2],
            padding                     = 0,
            text                        = '\U0000E0B2'
        ),
        widget.TextBox(
            background                  = colors_custom[2],
            font                        = 'Icons',
            fontsize                    = 20,
            foreground                  = '#000000',
            padding                     = 0,
            text                        = '\U0000F2E4'
        ),
        widget.Backlight(
            background                  = colors_custom[2],
            backlight_name              = 'intel_backlight',
            foreground                  = '#000000',
            format                      = '{percent:2.0%}',
            padding                     = 5
        ),
        widget.TextBox(
            background                  = colors_custom[2],
            fontsize                    = 16,
            foreground                  = '#000000',
            padding                     = 5,
            text                        = '|'
        ),
        widget.TextBox(
            background                  = colors_custom[2],
            fontsize                    = 16,
            foreground                  = '#000000',
            padding                     = 5,
            text                        = '\U0000F028 '
        ),
        widget.Volume(
            background                  = colors_custom[2],
            foreground                  = '#000000',
            volume_app                  = 'alsamixer',
            update_interval             = 0.1
        ),
        widget.TextBox(
            background                  = colors_custom[2],
            fontsize                    = 16,
            foreground                  = '#000000',
            padding                     = 0,
            text                        = ' | '
        ),
        widget.Battery(
            background                  = colors_custom[2],
            charge_char                 = '\U0000F583',
            discharge_char              = '\U0000F57E',
            empty_char                  = '\U0000F58D',
            foreground                  = '#000000',
            format                      = '{char} {percent:2.0%}',
            fontsize                    = 16,
            full_char                   = '\U0000F578',
            low_percentage              = 0.21,
            padding                     = 0,
            show_short_text             = False,
            update_interval             = 1,
            unknown_char                = '\U0000F590'
        ),
        my_sep(b=colors_custom[2], p=10),
        widget.TextBox(
            background                  = colors_custom[2],
            fontsize                    = 35,
            foreground                  = colors_custom[3],
            padding                     = 0,
            text                        = '\U0000E0B2'
        ),
        widget.TextBox(
            background                  = colors_custom[3],
            fontsize                    = 16,
            foreground                  = '#000000',
            padding                     = 2,
            text                        = '\U0000F5ED '
        ),
        widget.Clock(
            background                  = colors_custom[3],
            foreground                  = '#000000',
            format                      = '%a, %b %d - %Y',
            padding                     = 0
        ),
        widget.TextBox(
            background                  = colors_custom[3],
            fontsize                    = 16,
            foreground                  = '#000000',
            padding                     = 0,
            text                        = ' | '
        ),
        widget.TextBox(
            background                  = colors_custom[3],
            fontsize                    = 16,
            foreground                  = '#000000',
            padding                     = 0,
            text                        = '\U0000E384 '
        ),
        widget.Clock(
            background                  = colors_custom[3],
            foreground                  = '#000000',
            format                      = '%H:%M',
            padding                     = 5
        ),
        my_sep(b=colors_custom[3], p=5),
    ]

def my_widgets2():
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
            highlight_color             = colors_standard[1],
            highlight_method            = 'line',
            inactive                    = colors_custom[8],
            margin_x                    = 0,
            margin_y                    = 4,
            other_current_screen_border = colors_standard[1],
            other_screen_border         = colors_standard[1],
            padding_x                   = 3,
            padding_y                   = 5,
            rounded                     = False,
            this_current_screen_border  = colors_custom[9],
            this_screen_border          = colors_custom[13],
            use_mouse_wheel             = False
        ),
        my_sep(),
        widget.Prompt(
            font                        = 'SourceCodePro',
            fontsize                    = 16,
            foreground                  = colors_custom[7],
            prompt                      = ': '
        ),
        widget.Spacer(bar.STRETCH),
        my_sep(),
        widget.TextBox(
            background                  = colors_standard[1],
            font                        = 'Icons',
            fontsize                    = 16,
            foreground                  = colors_custom[1],
            padding                     = 0,
            text                        = '\U0000F109  '
        ),
        widget.Memory(
            background                  = colors_standard[1],
            foreground                  = colors_custom[1],
            format                      = 'RAM: {MemPercent}%',
            padding                     = 0,
            update_interval             = 1
        ),
        widget.CPU(
            background                  = colors_standard[1],
            foreground                  = colors_custom[1],
            format                      = ' | CPU: {load_percent}%',
            padding                     = 0,
            update_interval             = 1
        ),
        my_sep(b=colors_standard[1], p=10),
        widget.CurrentLayoutIcon(
            background                  = colors_standard[1],
            custom_icon_paths           = [ os.path.join(qtile_root, 'icons_cyan_outline/') ],
            foreground                  = '#000000',
            padding                     = 0,
            scale                       = 0.5
        ),
        widget.CurrentLayout(
            background                  = colors_standard[1],
            foreground                  = colors_custom[6],
            padding                     = 2
        ),
        my_sep(b=colors_standard[1], p=15),
        widget.TextBox(
            background                  = colors_standard[1],
            font                        = 'Icons',
            fontsize                    = 14,
            foreground                  = colors_custom[5],
            mouse_callbacks = {
                'Button1': nm_applet,
                'Button3': close_nm_applet,
            },
            padding                     = 0,
            text                        = '\U0000F09E  '
        ),
        widget.Wlan(
            background                  = colors_standard[1],
            foreground                  = colors_custom[5],
            format                      = '{essid}',
            interface                   = 'wlp1s0',
            mouse_callbacks = {
                'Button1': nm_applet,
                'Button3': close_nm_applet,
            },
            padding                     = 0
        ),
        my_sep(b=colors_standard[1], p=10),
        widget.TextBox(
            background                  = colors_standard[1],
            font                        = 'Icons',
            fontsize                    = 20,
            foreground                  = colors_custom[2],
            padding                     = 2,
            text                        = ' \U0000F2E4'
        ),
        widget.Backlight(
            background                  = colors_standard[1],
            backlight_name              = 'intel_backlight',
            foreground                  = colors_custom[2],
            format                      = '{percent:2.0%}',
            padding                     = 5
        ),
        widget.TextBox(
            background                  = colors_standard[1],
            fontsize                    = 16,
            foreground                  = colors_custom[2],
            padding                     = 5,
            text                        = '|'
        ),
        widget.TextBox(
            background                  = colors_standard[1],
            fontsize                    = 16,
            foreground                  = colors_custom[2],
            padding                     = 5,
            text                        = '\U0000F028 '
        ),
        widget.Volume(
            background                  = colors_standard[1],
            foreground                  = colors_custom[2],
            volume_app                  = 'alsamixer',
            update_interval             = 0.1
        ),
        widget.TextBox(
            background                  = colors_standard[1],
            fontsize                    = 16,
            foreground                  = colors_custom[2],
            padding                     = 0,
            text                        = ' | '
        ),
        widget.Battery(
            background                  = colors_standard[1],
            charge_char                 = '\U0000F583',
            discharge_char              = '\U0000F57E',
            empty_char                  = '\U0000F58D',
            foreground                  = colors_custom[2],
            format                      = '{char} {percent:2.0%}',
            fontsize                    = 16,
            full_char                   = '\U0000F578',
            low_percentage              = 0.21,
            padding                     = 0,
            show_short_text             = False,
            update_interval             = 1,
            unknown_char                = '\U0000F590'
        ),
        my_sep(b=colors_standard[1]),
        widget.TextBox(
            background                  = colors_standard[1],
            fontsize                    = 16,
            foreground                  = colors_custom[3],
            padding                     = 2,
            text                        = '\U0000F5ED '
        ),
        widget.Clock(
            background                  = colors_standard[1],
            foreground                  = colors_custom[3],
            format                      = '%a, %b %d (%Y)',
            padding                     = 0
        ),
        widget.TextBox(
            background                  = colors_standard[1],
            fontsize                    = 16,
            foreground                  = colors_custom[3],
            padding                     = 0,
            text                        = ' | '
        ),
        widget.TextBox(
            background                  = colors_standard[1],
            fontsize                    = 16,
            foreground                  = colors_custom[3],
            padding                     = 0,
            text                        = '\U0000E384 '
        ),
        widget.Clock(
            background                  = colors_standard[1],
            foreground                  = colors_custom[3],
            format                      = '%H:%M',
            padding                     = 5
        ),
        my_sep(b=colors_standard[1], p=5),
    ]

def my_widgets3():
    return [
        widget.GroupBox(
            active                      = colors_custom[7],
            background                  = colors_standard[5],
            borderwidth                 = 4,
            font                        = 'Sans Mono Bold',
            fontsize                    = 12,
            highlight_color             = colors_standard[6],
            highlight_method            = 'line',
            inactive                    = colors_custom[6],
            margin_x                    = 0,
            margin_y                    = 4,
            other_current_screen_border = colors_standard[1],
            other_screen_border         = colors_standard[1],
            padding_x                   = 3,
            padding_y                   = 5,
            rounded                     = False,
            this_current_screen_border  = colors_custom[6],
            this_screen_border          = colors_standard[6],
            use_mouse_wheel             = False
        ),
        my_sep(b=colors_custom[0]),
        widget.Prompt(
            background                  = colors_custom[0],
            font                        = 'SourceCodePro',
            fontsize                    = 16,
            foreground                  = colors_custom[7],
            prompt                      = ': '
        ),
        widget.Spacer(bar.STRETCH, background=colors_custom[0]),
        widget.Systray(
            background                  = colors_custom[0],
            icon_size                   = 20,
            padding                     = 2
        ),
        my_sep(b=colors_custom[0], p=5),
        my_sep(b=colors_standard[5], p=10),
        widget.TextBox(
            foreground                  = colors_custom[4],
            mouse_callbacks = {
                'Button1': nm_applet,
                'Button3': close_nm_applet,
            },
            padding                     = 0,
            text                        = 'Wifi: '
        ),
        widget.Wlan(
            foreground                  = colors_custom[7],
            format                      = '{essid}',
            interface                   = 'wlp1s0',
            mouse_callbacks = {
                'Button1': nm_applet,
                'Button3': close_nm_applet,
            },
            padding                     = 0
        ),
        widget.TextBox(
            fontsize                    = 16,
            foreground                  = colors_custom[4],
            padding                     = 0,
            text                        = '  Brightness: '
        ),
        widget.Backlight(
            backlight_name              = 'intel_backlight',
            foreground                  = colors_custom[7],
            format                      = '{percent:2.0%}',
            padding                     = 0
        ),
        widget.TextBox(
            fontsize                    = 16,
            foreground                  = colors_custom[4],
            padding                     = 0,
            text                        = '  Volume: '
        ),
        widget.Volume(
            foreground                  = colors_custom[7],
            volume_app                  = 'alsamixer',
            update_interval             = 0.1
        ),
        widget.TextBox(
            fontsize                    = 16,
            foreground                  = colors_custom[4],
            padding                     = 0,
            text                        = '  Battery: '
        ),
        widget.Battery(
            foreground                  = colors_custom[7],
            format                      = '{percent:2.0%}',
            fontsize                    = 16,
            low_percentage              = 0.21,
            padding                     = 0,
            show_short_text             = False,
            update_interval             = 1,
        ),
        my_sep(b=colors_standard[5], p=10),
        my_sep(b=colors_custom[6], p=10),
        widget.Clock(
            background                  = colors_custom[6],
            foreground                  = colors_custom[0],
            format                      = '%a, %b %d (%Y) %H:%M ',
            padding                     = 0
        ),
        widget.CurrentLayoutIcon(
            # custom_icon_paths           = [ os.path.join(qtile_root, 'icons_cyan_outline/') ],
            foreground                  = '#000000',
            padding                     = 0,
            scale                       = 0.5
        ),
    ]
