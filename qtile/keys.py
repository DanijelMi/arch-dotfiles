from libqtile.config import Group
from libqtile.command import lazy
from libqtile.config import EzKey

import solarized
from dropdown import DropDown

# left, down, up, right = 'hjkl'
mod = 'mod4'
layout = lazy.layout

"""
for available keysims check this dictionary:
from libqtile.xkeysyms import keysyms
and for modifiers:
    'M': 'mod4'
    'A': 'mod1'
    'S': 'shift'
    'C': 'control'
"""
# drop_down_terminal = DropDown('urxvt', width=0.8, height=0.6, x=0.1, y=0, opacity=0.4, border_focus=solarized.base0)
keymap = {
    # '<F12>': drop_down_terminal.toggle_function,
    # Switch between windows in current stack pane
    'M-h': layout.left(),
    'M-k': layout.up(),
    'M-j': layout.down(),
    'M-l': layout.right(),
    # Move windows up or down in current layout
    'M-S-k': layout.shuffle_up(),
    'M-S-j': layout.shuffle_down(),
    'M-S-h': layout.swap_left(),
    'M-S-l': layout.swap_right(),
    # Window Manipulation
    'M-i': layout.grow(),
    'M-m': layout.shrink(),
    'M-n': layout.normalize(),
    'M-o': layout.maximize(),
    'M-S-<space>': layout.flip(),
    'M-<space>': lazy.window.toggle_floating(),
    'M-S-<Return>': lazy.window.toggle_split(),
    # 'M-<Return>': lazy.spawn('st'),
    'M-q': lazy.window.kill(),
    'M-f': lazy.window.toggle_fullscreen(),
    # System

    # Switch between layouts
    'M-<Tab>': lazy.next_layout(),
    'M-S-<Tab>': lazy.prev_layout(),

    # Move to left/right group
    'M-<Right>': lazy.screen.next_group(),
    'M-<Left>': lazy.screen.prev_group(),

    'M-S-c': lazy.window.kill(),    # Kill selected window
    'M-C-r': lazy.restart(),
    'M-C-q': lazy.shutdown(),
    # Launchers
    # 'M-d': lazy.spawn('rofi -show drun -modi drun,run'),
    # 'M-e': lazy.spawn('rofi -show window -modi window'),
    # Laptop keys
    # '<XF86MonBrightnessUp>': lazy.spawn('xbacklight -inc 10'),
    # '<XF86MonBrightnessDown>': lazy.spawn('xbacklight -dec 10'),
    # '<XF86AudioMute>': lazy.spawn('pactl set-sink-mute @DEFAULT_SINK@ toggle'),
    # '<XF86AudioMicMute>': lazy.spawn('pactl set-sink-mute @DEFAULT_SINK@ toggle'),
    # '<XF86AudioRaiseVolume>': lazy.spawn('pactl set-sink-volume @DEFAULT_SINK@ +2%'),
    # '<XF86AudioLowerVolume>': lazy.spawn('pactl set-sink-volume @DEFAULT_SINK@ -2%'),
    # Other
    # 'M-r': lazy.spawn('urxvt -e /usr/bin/ranger'),

}

# Switch to group
groups = [Group(i) for i in "1234567890"]
for i in groups:
    keymap[f'M-{i.name}'] = lazy.group[i.name].toscreen()
    keymap[f'M-S-{i.name}'] = lazy.window.togroup(i.name)


keys = [EzKey(k, v) for k, v in keymap.items()]
