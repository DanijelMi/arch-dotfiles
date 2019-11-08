#!/usr/bin/env bash
# Author: Danijel Milosevic

polybar_redraw(){
    pkill polybar
    for m in $(polybar --list-monitors | cut -d":" -f1); do
        MONITOR=$m polybar --reload main &
    done
}

# Define a main monitor so you could potentially assign more virtual desktops there
bspwm_desktops(){
    MAIN_MONITOR="eDP1"
    for monitor in $(bspc query -M --names); do
        if [[ $monitor == $MAIN_MONITOR ]]; then
            bspc monitor $monitor -d 1 2 3 4 5 6 7 # Virtual desktops for the main monitor
        else
            bspc monitor $monitor -d 1 2 3 # Virtual desktops for other monitors
        fi
    done
}

xrandr --auto        # Enable disabled connected monitors or disable enabled disconnected monitors
sleep 2
nitrogen --restore   # Restore wallpapers
polybar_redraw       # Kill and spawn polybar for each monitor
bspwm_desktops       # Create bspwm virtual desktops for each montior

#autorandr -c   # Load saved xrandr configuration (Monitor layouts)
#tint2 &          # Taskbar

#export DISPLAY=:0.0