#!/usr/bin/env bash
# Source this script within other tools to get data of currently focused window and screen
# Useful for restricting window movement within monitor bounds
declare {x,y,w,h,W,H}=0
eval $(xwininfo -root |
sed -n -e "s/^ \+Width: \+\([0-9]\+\).*/W=\1/p" \
       -e "s/^ \+Height: \+\([0-9]\+\).*/H=\1/p" )
#echo "W$W H$H"

eval $(xwininfo -id $(xdotool getactivewindow) |
  sed -n -e "s/^ \+Absolute upper-left X: \+\([0-9]\+\).*/x=\1/p" \
    -e "s/^ \+Absolute upper-left Y: \+\([0-9]\+\).*/y=\1/p" \
    -e "s/^ \+Width: \+\([0-9]\+\).*/w=\1/p" \
    -e "s/^ \+Height: \+\([0-9]\+\).*/h=\1/p" )
#echo "x$x y$y w$w h$h"

return 0

# top_dist=$y
# bottom_dist=$(($H-$y-$h))
# left_dist=$x
# right_dist=$(($W-$x-$w))