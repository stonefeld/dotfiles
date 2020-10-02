import os
import re
import socket
import subprocess
from libqtile.config import Click, Drag, Group, Key, Screen
from libqtile.config import ScratchPad, DropDown
from libqtile.lazy import lazy
from libqtile import bar, layout, widget, hook
from typing import List

mod = "mod4"
myTerm = "alacritty"

keys = [
    # Launch my terminal
    Key([mod], "Return", lazy.spawn(myTerm)),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout()),
    Key([mod, "shift"], "Tab", lazy.prev_layout()),

    # Kill a window
    Key([mod, "shift"], "w", lazy.window.kill()),

    # Kill and restart qtile
    Key([mod, "control"], "q", lazy.shutdown()),
    Key([mod, "control"], "r", lazy.restart()),

    # Switch keyboard focus from monitors
    Key([mod], "q", lazy.to_screen(1)),
    Key([mod], "w", lazy.to_screen(0)),
    Key([mod], "period", lazy.next_screen()),
    Key([mod], "comma", lazy.prev_screen()),

    # Switch window focus to other pane(s) of stack
    Key([mod], "space", lazy.layout.next()),
    Key([mod], "r", lazy.layout.next()),

    # Switch between windows in current stack pane
    Key([mod], "k", lazy.layout.down()),
    Key([mod], "j", lazy.layout.up()),

    # Swap panes of split stack
    Key([mod, "shift"], "space", lazy.layout.rotate(), lazy.layout.flip()),
    Key([mod, "shift"], "Return", lazy.layout.toggle_split()),

    # Window controls
    Key([mod], "h", lazy.layout.grow(), lazy.layout.increase_nmaster()),
    Key([mod], "l", lazy.layout.shrink(), lazy.layout.decrease_nmaster()),
    Key([mod], "n", lazy.layout.normalize()),
    Key([mod], "m", lazy.layout.maximize()),
    Key([mod, "shift"], "f", lazy.window.toggle_floating()),
    Key([mod, "shift"], "m", lazy.window.toggle_fullscreen()),

    # Open file manager
    Key([mod], "e", lazy.spawn("Thunar")),

    # Rofi commands
    Key([mod], "s", lazy.spawn("rofi -modi window,drun,run,calc -show drun -monitor eDP-1 -icon-theme Papirus-Dark -show-icons -icon-size 20")),
    Key([mod], "r", lazy.spawn("rofi -modi window,drun,run,calc -show run -monitor eDP-1")),
    Key([mod], "c", lazy.spawn("rofi -modi window,drun,run,calc -show calc -monitor eDP-1 -icon-theme Papirus-Dark -show-icons -icon-size 20")),
    Key(["mod1"], "Tab", lazy.spawn("rofi -modi window,drun,run,calc -show window -monitor eDP-1 -icon-theme Papirus-Dark -show-icons -icon-size 20")),
]

group_names = [
    ("WWW",     { 'layout': 'monadtall' }),
    ("DEV-1",   { 'layout': 'monadtall' }),
    ("DEV-2",   { 'layout': 'monadtall' }),
    ("DEV-3",   { 'layout': 'monadtall' }),
    ("DOC",     { 'layout': 'monadtall' }),
    ("MUS",     { 'layout': 'monadtall' }),
    ("CHAT",    { 'layout': 'monadtall' }),
    ("MAIL",    { 'layout': 'monadtall' }),
    ("TERM",    { 'layout': 'monadtall' }),
]

groups = [Group(name, **kwargs) for name, kwargs in group_names]

for i, (name, kwargs) in enumerate(group_names, 1):
    keys.append(Key([mod], str(i), lazy.group[name].toscreen()))
    keys.append(Key([mod, "shift"], str(i), lazy.window.togroup(name)))

layout_theme = {
    "border_width": 2,
    "margin": 10,
    "border_focus": "#E1ACff",
    "border_normal": "#1D2330"
}

layouts = [
    layout.MonadTall(**layout_theme),
    layout.Max(**layout_theme),
    layout.Stack(num_stacks=2, **layout_theme),
    layout.RatioTile(**layout_theme),
]

colors = [
    ["#292D3E", "#292D3E"], # panel background
    ["#434758", "#434758"], # background for current screen tab
    ["#FFFFFF", "#FFFFFF"], # font color for group names
    ["#FF5555", "#FF5555"], # border line color for current tab
    ["#8D62A9", "#8D62A9"], # border line color for other tab and odd widgets
    ["#668BD7", "#668BD7"], # color for the even widgets
    ["#E1ACff", "#E1ACff"], # window name
    ["#808080", "#808080"]  # color for inactive group names
]

colors_nord = [
    ["#3B4252", "#3B4252"],
    ["#BD616A", "#BD616A"],
    ["#A3BE8C", "#A3BE8C"],
    ["#EBCB8B", "#EBCB8B"],
    ["#81A1C1", "#81A1C1"],
    ["#B48EAD", "#B48EAD"],
    ["#88C0D0", "#88C0D0"],
    ["#E5E9F0", "#E5E9F0"]
]

widget_defaults = dict(
    font = 'FantasqueSansMono Nerd Font',
    fontsize = 16,
    padding = 2,
    background = colors[0]
)
extension_defaults = widget_defaults.copy()

def init_widgets_list():
    widgets_list = [
        widget.TextBox(
            background = colors[0],
            fontsize = 18,
            foreground = colors_nord[1],
            mouse_callbacks = {
                'Button3': lambda qtile: qtile.cmd_spawn("/usr/bin/xmenu &"),
            },
            padding = 0,
            text = ' \U0000F303  '
        ),
        widget.GroupBox(
            active = colors[2],
            background = colors[0],
            borderwidth = 4,
            font = 'Sans Mono Bold',
            fontsize = 12,
            foreground = colors[2],
            highlight_color = colors[1],
            highlight_method = 'block',
            inactive = colors[7],
            margin_x = 0,
            margin_y = 3,
            other_current_screen_border = colors[0],
            other_screen_border = colors[0],
            padding_x = 3,
            padding_y = 3,
            rounded = False,
            this_current_screen_border = colors[3],
            this_screen_border = colors[4]
        ),
        widget.Sep(
            background = colors[0],
            linewidth = 0,
            padding = 20
        ),
        widget.WindowName(
            background = colors[0],
            font = "Dejavu Sans Mono",
            fontsize = 14,
            foreground = colors[6],
            padding = 0
        ),
        widget.Sep(
            background = colors[0],
            linewidth = 0,
            padding = 20
        ),
        widget.TextBox(
            background = colors[0],
            font = 'Icons',
            fontsize = 40,
            foreground = colors_nord[1],
            padding = 0,
            text = '\U0000F0D9'
        ),
        widget.TextBox(
            background = colors_nord[1],
            font = 'Icons',
            fontsize = 16,
            foreground = '#000000',
            mouse_callbacks = {
                'Button1': lambda qtile: qtile.cmd_spawn(myTerm + ' -e htop &'),
                'Button3': lambda qtile: qtile.cmd_spawn(myTerm + ' -e killall htop')
            },
            padding = 0,
            text = ' \U0000F109  '
        ),
        widget.Memory(
            background = colors_nord[1],
            foreground = '#000000',
            format = 'RAM: {MemPercent}%',
            mouse_callbacks = {
                'Button1': lambda qtile: qtile.cmd_spawn(myTerm + ' -e htop &'),
                'Button3': lambda qtile: qtile.cmd_spawn(myTerm + ' -e killall htop')
            },
            padding = 0,
            update_interval = 1
        ),
        widget.CPU(
            background = colors_nord[1],
            foreground = '#000000',
            format = ' | CPU: {load_percent}%',
            mouse_callbacks = {
                'Button1': lambda qtile: qtile.cmd_spawn(myTerm + ' -e htop &'),
                'Button3': lambda qtile: qtile.cmd_spawn(myTerm + ' -e killall htop')
            },
            padding = 0,
            update_interval = 1
        ),
        widget.Sep(
            background = colors_nord[1],
            linewidth = 0,
            padding = 10
        ),
        widget.TextBox(
            background = colors_nord[1],
            font = 'Icons',
            fontsize = 40,
            foreground = colors_nord[6],
            padding = 0,
            text = '\U0000F0D9'
        ),
        widget.CurrentLayoutIcon(
            background = colors_nord[6],
            custom_icon_paths = [os.path.expanduser("~/.config/qtile/icons")],
            foreground = '#000000',
            padding = 0,
            scale = 0.7
        ),
        widget.Sep(
            background = colors_nord[6],
            linewidth = 0,
            padding = 2
        ),
        widget.CurrentLayout(
            background = colors_nord[6],
            foreground = '#000000',
            padding = 0
        ),
        widget.Sep(
            background = colors_nord[6],
            linewidth = 0,
            padding = 10
        ),
        widget.TextBox(
            background = colors_nord[6],
            font = 'Icons',
            fontsize = 40,
            foreground = colors_nord[5],
            padding = 0,
            text = '\U0000F0D9'
        ),
        widget.TextBox(
            background = colors_nord[5],
            font = 'Icons',
            fontsize = 14,
            foreground = '#000000',
            padding = 0,
            text = ' \U0000F09E  '
        ),
        widget.Wlan(
            background = colors_nord[5],
            foreground = '#000000',
            interface = 'wlp1s0',
            mouse_callbacks = {
                'Button1': lambda qtile: qtile.cmd_spawn('nm-applet'),
                'Button3': lambda qtile: qtile.cmd_spawn('killall nm-applet')
            },
            padding = 0
        ),
        widget.Sep(
            background = colors_nord[5],
            linewidth = 0,
            padding = 5
        ),
        widget.TextBox(
            background = colors_nord[5],
            foreground = colors_nord[2],
            font = 'Icons',
            fontsize = 40,
            padding = 0,
            text = '\U0000F0D9'
        ),
        widget.TextBox(
            background = colors_nord[2],
            font = 'Icons',
            fontsize = 20,
            foreground = '#000000',
            padding = 0,
            text = ' \U0000F2E4 '
        ),
        widget.Backlight(
            background = colors_nord[2],
            backlight_name = 'intel_backlight',
            foreground = '#000000',
            format = '{percent:2.0%}',
            padding = 0
        ),
        widget.TextBox(
            background = colors_nord[2],
            fontsize = 16,
            foreground = '#000000',
            padding = 0,
            text = ' | \U0000F357 '
        ),
        widget.Volume(
            background = colors_nord[2],
            foreground = '#000000',
            volume_app = 'alsamixer',
            update_interval = 0.1
        ),
        widget.TextBox(
            background = colors_nord[2],
            fontsize = 16,
            foreground = '#000000',
            padding = 0,
            text = ' | '
        ),
        widget.Battery(
            background = colors_nord[2],
            charge_char = '\U0000F583',
            discharge_char = '\U0000F57E',
            empty_char = '\U0000F58D',
            foreground = '#000000',
            format = '{char} {percent:2.0%}',
            fontsize = 16,
            full_char = '\U0000F578',
            low_percentage = 0.2,
            padding = 0,
            show_short_text = False,
            update_interval = 1,
            unknown_char = '\U0000F590'
        ),
        widget.Sep(
            background = colors_nord[2],
            linewidth = 0,
            padding = 10
        ),
        widget.TextBox(
            background = colors_nord[2],
            font = 'Icons',
            fontsize = 40,
            foreground = colors_nord[3],
            padding = 0,
            text = '\U0000F0D9'
        ),
        widget.TextBox(
            text = '\U0000F5EC ',
            fontsize = 16,
            foreground = '#000000',
            background = colors_nord[3],
            padding = 5
        ),
        widget.Clock(
            background = colors_nord[3],
            foreground = '#000000',
            format = '%a, %b %d - %Y',
            padding = 0
        ),
        widget.TextBox(
            background = colors_nord[3],
            fontsize = 16,
            foreground = '#000000',
            padding = 0,
            text = ' | '
        ),
        widget.TextBox(
            background = colors_nord[3],
            fontsize = 14,
            foreground = '#000000',
            padding = 0,
            text = '\U0000F64F '
        ),
        widget.Clock(
            background = colors_nord[3],
            foreground = '#000000',
            format = '%H:%M',
            padding = 5
        ),
        widget.Sep(
            background = colors_nord[3],
            linewidth = 0,
            padding = 5
        ),
        widget.Systray(
            background = colors[0],
            padding = 5
        ),
    ]
    return widgets_list

def init_widgets_screen1():
    widgets_screen1 = init_widgets_list()
    return widgets_screen1

def init_widgets_screen2():
    widgets_screen2 = init_widgets_list()
    return widgets_screen2

def init_screens():
    return [
        Screen(top=bar.Bar(widgets=init_widgets_screen1(), opacity=1.0, size=20)),
        Screen(top=bar.Bar(widgets=init_widgets_screen2(), opacity=1.0, size=20))
    ]

if __name__ in ["config", "__main__"]:
    screens = init_screens()
    widgets_list = init_widgets_list
    widgets_screen1 = init_widgets_screen1()
    widgets_screen2 = init_widgets_screen2()

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None  # WARNING: this is deprecated and will be removed soon
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False

floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    {"role":    'pop-up'},
    {'wname':   'branchdialog'},  # gitk
    {'wname':   'pinentry'},  # GPG key password entry
    {'wname':   'Discord Updater'},
    {'wmclass': 'confirm'},
    {'wmclass': 'dialog'},
    {'wmclass': 'download'},
    {'wmclass': 'error'},
    {'wmclass': 'file_progress'},
    {'wmclass': 'notification'},
    {'wmclass': 'splash'},
    {'wmclass': 'toolbar'},
    {'wmclass': 'confirmreset'},  # gitk
    {'wmclass': 'makebranch'},  # gitk
    {'wmclass': 'maketag'},  # gitk
    {'wmclass': 'ssh-askpass'},  # ssh-askpass
    {'wmclass': 'VirtualBox Manager'},
    {'wmclass': 'lxappearance'},
    {'wmclass': 'Thunar'},
    {'wmclass': 'pavucontrol'},
    {'wmclass': 'Msgcompose'},
    {'wmclass': 'nitrogen'}
])
auto_fullscreen = True
focus_on_window_activation = "smart"

@hook.subscribe.startup
def startup():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/autostart.sh'])

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
