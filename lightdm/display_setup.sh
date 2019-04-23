#!/bin/sh

# If "VGA1" display exists, expand the display on the right
xrandr | grep VGA1 > /dev/null && xrandr --output VGA1 --preferred --pos 1367x0

# Not sure, recommended by the wiki wizards
xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto
