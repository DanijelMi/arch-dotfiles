#!/usr/bin/env bash

# Status bar
# while true; do
#     dwm-status
#     sleep 1
# done &

#xmodmap -e "keycode 108 = Super_L"  # reassign Alt_R to Super_L
#xmodmap -e "remove mod1 = Super_L"  # make sure X keeps it out of the mod1 group
#setxkbmap us &      # Set keyboard layout to us
# font... Disabled until I figure out how this part works
# xset fp+ $HOME/.fonts &
# xset fp rehash &

#wmname LG3D     # This fixes many java apps, and the reason is retarded so you don't need to know why just trust it ok
# Makes quick-restart of DWM possible by killing it.
# For a permanent kill, target the underlying launcher (such as login manager or startx)

#while true; do
exec dwm
#done
