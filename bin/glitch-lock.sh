#!/usr/bin/env bash
# Takes a picture of desktop with scrot, applies glitchy effects to it
# Then locks screen and applying the glitchy pic as background
# https://github.com/r00tman/corrupter
tmpbg="/tmp/screen.png"
scrot --silent "$tmpbg"
corrupter -add 5 -bheight 7 -boffset 8 -mag 1 -lr -15 "$tmpbg" "$tmpbg"
i3lock --ignore-empty-password -i "$tmpbg"
rm "$tmpbg"
