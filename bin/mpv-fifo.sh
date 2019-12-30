#!/usr/bin/env bash
# Author: Danijel Milosevic
# License: Beerware
# Wrapper script that launches MPV to play clipboard (xclip) contents. Main intended use is for youtube.
# If an specifically-named MPV instance already exists, then just add the content in the queue instead of launching a new one

# Make fifo if it doesn't existhttps://www.youtube.com/watch?v=K0-CW1DbVIg&list=PLqHFK9K-VRS_BogIgYb-_cPFUjCuwzEyk
FIFO_PIPE=/tmp/mpv-fifo
MPV_IPC_NAME="main_player"

# If the pipe doesn't exist, create it
if ! [ -p "$FIFO_PIPE" ]; then
  notify-send "Creating pipe..."
  mkfifo /tmp/mpv-fifo
fi

# If specifically named mpv exists, yeet a command into the FIFO
if xdotool search --name "$MPV_IPC_NAME" ; then
  notify-send "Sending pipe"
  printf "%s\n" "loadfile \"$(xclip -o -selection "clipboard")\" append-play" > $FIFO_PIPE
else   # Create a new mpv instance
  notify-send "launching mpv"
  mpv --title="$MPV_IPC_NAME" \
  --keepaspect \
  --autofit-larger=100%x100% \
  --ytdl-raw-options="yes-playlist=" \
  --idle=yes \
  --save-position-on-quit \
  --keep-open=yes \
  --player-operation-mode=pseudo-gui \
  --input-file \
  /tmp/mpv-fifo $(xclip -o -selection "clipboard")
fi
