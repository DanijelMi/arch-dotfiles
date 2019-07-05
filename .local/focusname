#!/usr/bin/env bash
echo "$(xprop -id $(xdotool getactivewindow) | grep -m 1 -Po '(WM_CLASS.*\K".*")')"