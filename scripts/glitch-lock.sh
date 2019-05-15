#!/usr/bin/env bash
# Takes a picture of desktop with scrot, applies glitchy effects
# locks screen with that processed image
# corrupter: https://github.com/r00tman/corrupter

# Place to temporarily store the lockscreen image
TMP_BG="/tmp/lockscreen.png"

# Check dependencies
DEPENDENCIES=(scrot i3lock corrupter)
for i in "${DEPENDENCIES[@]}"; do
   which $i &> /dev/null || printf "$i was not found on your system.\n"
done

# Take screenshot and store it in temporary directory
scrot --silent "$TMP_BG" # --silent removes the system BEEP

# Processes and overwrites the clean image with following effects:
ARGS=(-add 5        # 0-255 brightness control
      -bheight 3    # average distroted block height
      -boffset 8    # distorted block offset strength
      -lag 0.005    # per-channel scanline lag strength
      -lb 3         # blue scanline lag
      -lg 3         # green scanline lag
      -lr -15       # redline lag
      -mag 1        # dissolve blur strength
      -meanabber 10 # mean chromatic abberation offset
      -stdabber 10  # std. dev. of chromatic abberation offset
      -stdoffset 10 # std. dev. of red-blue channel offset
      -stride 0.1   # distorted block stride strength
      "$TMP_BG" "$TMP_BG"   # source/destination file
     )
corrupter "${ARGS[@]}"

# Locks the screen with the processed image
i3lock --ignore-empty-password -i "$TMP_BG"
rm "$TMP_BG"    # Temp image cleanup
