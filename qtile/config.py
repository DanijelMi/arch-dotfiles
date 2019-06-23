from libqtile.config import Screen, Drag, Click
from libqtile.command import lazy
from libqtile import bar, widget, hook
from keys import keys, groups
from layouts import layouts, floating_layout
from scratchpad import remove_scratchpadded, set_scratchpadded

import os, subprocess

"""
This is main config file that should import all other config files and expose these variables:
    floating_layout groups keys
    layouts 
    mouse
    screens
    wmname
"""

mod = 'mod4'

# defaults for widgets and extensions
widget_defaults = dict(font='sans', fontsize=12, padding=3)

extension_defaults = widget_defaults.copy()
bottom_bar_widgets = [
    widget.CurrentLayoutIcon(),
    widget.GroupBox(),
    widget.Prompt(),
    widget.TaskList(rounded=False, margin_y=8, margin_x=1, padding_x=1),
    # widget.HDDBusyGraph(border_width=1, type='box'),
    # widget.MemoryGraph(),
    widget.Battery(),
    widget.Volume(),
    widget.Systray(),
    widget.Clock(format='%d.%m. %w %H:%M'),    # TIME
]

screens = [
    Screen(bottom=bar.Bar(size=30, widgets=bottom_bar_widgets)),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []
main = None
follow_mouse_focus = False
bring_front_click = True    # When clicked, window gets in front
cursor_warp = True          # Cursor follows focused windows
auto_fullscreen = True      # Apps request for fullscreen is allowed
focus_on_window_activation = "smart"

wmname = "LG3D" # Needed var for some java apps


# @hook.subscribe.startup_once  # This one is from the docs..
@hook.subscribe.startup
def autostart():
    home = os.path.expanduser('~/.config/qtile/autostart.sh')
    subprocess.call([home])                     
    # os.system('feh --bg-scale ~/.wallpaper')    # Set wallpaper


@hook.subscribe.client_new
def dialogs(window):
    if window.window.get_wm_type() == 'dialog' or window.window.get_wm_transient_for():
        window.floating = True
