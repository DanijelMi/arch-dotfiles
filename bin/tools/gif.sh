#!/usr/bin/env bash
export TMPFILE="$(mktemp -t screencast-XXXXXXX).mkv"
export OUTPUT="$HOME/Downloads/$(date +%F-%H-%M-%S)"

record(){
    notify-send -t 4500 "Recording selection starts in 5 seconds..."
    sleep 5
    read -r X Y W H G ID < <(slop -f "%x %y %w %h %g %i")
    ffmpeg -f x11grab -s "$W"x"$H" -i :0.0+$X,$Y "$TMPFILE"
    notify-send 'Generating palette'
    ffmpeg -y -i "$TMPFILE"  -vf fps=10,palettegen /tmp/palette.png
    notify-send 'Generating gif'
    ffmpeg -i "$TMPFILE" -i /tmp/palette.png -filter_complex "paletteuse" $OUTPUT.gif
    mv $TMPFILE $OUTPUT.mkv
    notify-send "size $(du -h $OUTPUT.gif | awk '{print $1}')"
    mpv $OUTPUT.gif
    trap "rm -f '$TMPFILE'" 0
}

export -f record

$TERMINAL -e bash -c record