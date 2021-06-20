# LibQtile
from libqtile        import bar, widget
from libqtile.config import Screen

# Own
from colors          import *
from variables       import *
from widgets         import *

def my_main_screen():
    if option == 1:
        screen_main = my_widgets()

    elif option == 2:
        screen_main = my_widgets2()

    screen_main.append(widget.Systray(
        background = colors_standard[1],
        icon_size  = 20,
        padding    = 2
    ))
    return screen_main

def my_secondary_screen():
    if option == 1:
        screen_secondary = my_widgets()

    elif option == 2:
        screen_secondary = my_widgets2()

    screen_secondary.remove(screen_secondary[0])
    return screen_secondary

def my_screen():
    if option == 1:
        return [Screen(top=bar.Bar(widgets=my_main_screen(),      opacity=1.0, size=25, margin=6)),
                Screen(top=bar.Bar(widgets=my_secondary_screen(), opacity=1.0, size=25, margin=6))]

    elif option == 2:
        return [Screen(top=bar.Bar(widgets=my_main_screen(),      opacity=1.0, size=30, margin=6)),
                Screen(top=bar.Bar(widgets=my_secondary_screen(), opacity=1.0, size=30, margin=6))]
