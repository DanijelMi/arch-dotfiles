#!/usr/bin/sh

dir="$HOME/.config/polybar"

# launch_bar() {
#   pkill polybar
#   while pgrep polybar; do killall polybar; done
#   polybar -q main -c "$dir/config.ini"
# }
# launch_bar
pkill polybar
for m in $(polybar --list-monitors | cut -d":" -f1); do
    MONITOR=$m polybar --reload main -c "$dir/config.ini" &
    # MONITOR=$m polybar main &
done
