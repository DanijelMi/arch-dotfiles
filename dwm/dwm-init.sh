#!/usr/bin/env bash

# Time display
# while true; do
#    xsetroot -name "$( date +"%F %R" )"
#    sleep 1m    # Update time every minute
# done &

xmodmap -e "keycode 108 = Super_L"  # reassign Alt_R to Super_L
xmodmap -e "remove mod1 = Super_L"  # make sure X keeps it out of the mod1 group

xrdb -merge $HOME/.Xresources &     # Apply .Xresources config

setxkbmap us &      # Set keyboard layout to us

# font... Disabled until I figure out how this part works
# xset fp+ $HOME/.fonts &
# xset fp rehash &

# Makes quick-restart of DWM possible by killing it.
# For a permanent kill, target the underlying launcher (such as login manager or startx)
while true; do
    dwm 2> ~/.dwm.log       # Log stderror to a file
done