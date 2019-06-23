#!/bin/sh
# Sets the background. If given an argument, will set file as background.
[ ! -z "$1" ] && cp "$1" ~/.config/wallpaper && notify-send -i "$HOME/.config/wall.png" "Wallpaper changed."
xwallpaper --zoom ~/.config/wallpaper