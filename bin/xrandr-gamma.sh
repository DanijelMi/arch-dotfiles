#!/usr/bin/env bash
# Author: Danijel Milosevic
# License: Beerware
# Changes the "warmness" of monitor for purpose of blue-light protection
# The gamma scale changes are arbitrarily chosen, and are applied relatively

# There is a chance for 1.1.1 desync (potentially add safeguard for this)

gammaline=$(xrandr --verbose | grep eDP1 -A 7 | grep Gamma)
red=$(echo $gammaline | grep -o " [0-9].[0-9]*:")
green=$(echo $gammaline | grep -o ":[0-9].[0-9]*:")
blue=$(echo $gammaline | grep -o ":[0-9].[0-9]*$")

red=${red::-1}
green=${green:1:-1}
blue=${blue:1}

# If the values weren't symmetrical, it would be difficult to return to 1:1:1 gamma
case $1 in
  w) 
    r_mult=0.00
    g_mult=-0.05
    b_mult=-0.07
    if (( $(echo "$blue >= 3.0" | bc -l ))) ; then
      exit 0
    fi
    ;;
  c)
    r_mult=0.00
    g_mult=+0.05
    b_mult=+0.07
    if (( $(echo "$blue <= 0.5" | bc -l ))) ; then
      exit 0
    fi
    ;;
  r)
    for disp in $(xrandr | grep " connected" | awk '{print $1}'); do
        xrandr --output $disp --gamma 1:1:1 --brightness 1.0
    done 
    exit 0
esac

rred=$(echo "$red $r_mult" | awk '{printf "%.2f", ( 1 / $1 ) + $2}')
rgreen=$(echo "$green $g_mult" | awk '{printf "%.2f", ( 1 / $1 ) + $2}')
rblue=$(echo "$blue $b_mult" | awk '{printf "%.2f", ( 1 / $1 ) + $2}')

for disp in $(xrandr | grep " connected" | awk '{print $1}'); do
  xrandr --output $disp --gamma $rred:$rgreen:$rblue --brightness 1.0
done 
 #dunstify -r "20855" -a Gamma -u low -t 700 "$(xrandr --verbose | grep Gamma)"