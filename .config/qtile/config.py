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
home = os.path.expanduser('~')

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
    Key([mod], "j", lazy.layout.down()),
    Key([mod], "k", lazy.layout.up()),
    Key([mod], "l", lazy.layout.right()),
    Key([mod], "h", lazy.layout.left()),

    # Move windows in pane
    Key([mod, "shift"], "j", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up()),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right()),
    Key([mod, "shift"], "h", lazy.layout.shuffle_left()),

    # Swap panes of split stack
    Key([mod, "shift"], "space", lazy.layout.rotate(), lazy.layout.flip()),
    Key([mod, "shift"], "Return", lazy.layout.toggle_split()),

    # Window size controls
    Key([mod, "control"], "l", lazy.layout.grow_right(), lazy.layout.grow(), lazy.layout.increase_ratio(), lazy.layout.delete()),
    Key([mod, "control"], "h", lazy.layout.grow_left(), lazy.layout.shrink(), lazy.layout.decrease_ratio(), lazy.layout.add()),
    Key([mod, "control"], "k", lazy.layout.grow_up(), lazy.layout.grow(), lazy.layout.decrease_nmaster()),
    Key([mod, "control"], "j", lazy.layout.grow_down(), lazy.layout.shrink(), lazy.layout.increase_nmaster()),

    Key([mod, "shift"], "f", lazy.window.toggle_floating()),
    Key([], "F11", lazy.window.toggle_fullscreen()),

    Key([mod], "n", lazy.layout.normalize()),
    Key([mod], "m", lazy.layout.maximize()),

    Key([mod, "mod1"], "k", lazy.layout.flip_up()),
    Key([mod, "mod1"], "j", lazy.layout.flip_down()),
    Key([mod, "mod1"], "l", lazy.layout.flip_right()),
    Key([mod, "mod1"], "h", lazy.layout.flip_left()),

    # Open file manager
    Key([mod], "e", lazy.spawn("Thunar")),

    # Rofi commands
    Key([mod], "s", lazy.spawn("rofi -show drun")),
    Key([mod], "r", lazy.spawn("rofi -show run")),
    Key([mod], "c", lazy.spawn("rofi -show calc")),
    Key(["mod1"], "Tab", lazy.spawn("rofi -show window")),

    # Playerctl commands
    Key([mod, "shift"], "period", lazy.spawn("playerctl next")),
    Key([mod, "shift"], "comma", lazy.spawn("playerctl previous")),

    # Screeshot
    Key([], "Print", lazy.spawn("/usr/bin/scrot " + home + "/Pictures/screenshots/screenshot_%Y_%m_%d_%H_%M_%S.png")),
]

group_names = [
    ("WWW",     { 'layout': 'tile' }),
    ("DEV-1",   { 'layout': 'tile' }),
    ("DEV-2",   { 'layout': 'tile' }),
    ("DEV-3",   { 'layout': 'tile' }),
    ("DOC",     { 'layout': 'tile' }),
    ("MUS",     { 'layout': 'tile' }),
    ("CHAT",    { 'layout': 'tile' }),
    ("MAIL",    { 'layout': 'tile' }),
    ("TERM",    { 'layout': 'tile' }),
]

groups = [Group(name, **kwargs) for name, kwargs in group_names]

for i, (name, kwargs) in enumerate(group_names, 1):
    keys.append(Key([mod], str(i), lazy.group[name].toscreen()))
    keys.append(Key([mod, "shift"], str(i), lazy.window.togroup(name)))

layout_theme = {
    "border_width": 2,
    "margin": 7,
    "border_focus": "#E1ACff",
    "border_normal": "#1D2330"
}

layouts = [
    layout.Tile(**layout_theme),
    layout.Columns(num_columns=2, autosplit=True, **layout_theme),
    layout.Stack(num_stacks=2, **layout_theme),
    layout.MonadTall(**layout_theme),
    layout.MonadWide(**layout_theme),
    layout.Bsp(**layout_theme),
    layout.Zoomy(**layout_theme),
    layout.Max(**layout_theme),
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
            fontsize = 16,
            foreground = colors_nord[1],
            mouse_callbacks = {
                'Button3': lambda qtile: qtile.cmd_spawn("/usr/bin/xmenu &"),
            },
            padding = 10,
            text = '\U0000F111 '
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
            fontsize = 0,
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
            low_percentage = 0.21,
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
            text = '\U0000F5ED ',
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
    ]
    return widgets_list

def init_widgets_screen1():
    widgets_screen1 = init_widgets_list()
    widgets_screen1.append(widget.Systray(
        background = colors[0],
        padding = 5
    ))
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
    {'wmclass': 'nitrogen'},
    {'wmclass': 'xarchiver'},
    {'wmclass': 'gpicview'}
])
auto_fullscreen = True
focus_on_window_activation = "smart"

floating_types = [
    "notification", "toolbar", "splash", "dialog",
    "utility", "menu", "dropdown_menu", "popup_menu", "tooltip,dock",
]

@hook.subscribe.startup
def startup():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/autostart.sh'])

@hook.subscribe.client_new
def set_floating(window):
    if (window.window.get_wm_transient_for()
            or window.window.get_wm_type() in floating_types):
        window.floating = True

@hook.subscribe.client_new
def floating_dialogs(window):
    dialog = window.window.get_wm_type() == 'dialog'
    transient = window.window.get_wm_transient_for()
    if dialog or transient:
        window.floating = True

@hook.subscribe.client_focus
def bring_to_front_focus_client(window):
    if window.floating:
        window.cmd_bring_to_front()

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
