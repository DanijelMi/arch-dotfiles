#!/usr/bin/env bash
export TMPFILE="$(mktemp -t screencast-XXXXXXX).mkv"   # Temp file for processing
export OUTPUT="$HOME/Downloads/$(date +%F-%H-%M-%S)"   # Destination file path/name

# Check for dependencies
  DEPENDENCIES=(notify-send ffmpeg mpv)
  for i in "${DEPENDENCIES[@]}"; do
    which $i &> /dev/null && continue
    printf "$i was not found on your system. Aborting.\n" ; return 1
  done

record(){
    notify-send -t 2500 "Recording selection starts in 3 seconds..."
    sleep 3
    read -r X Y W H G ID < <(slop -f "%x %y %w %h %g %i")     # Recording area selector
    ffmpeg -f x11grab -s "$W"x"$H" -i :0.0+$X,$Y "$TMPFILE"   # Store recording to temp file
    mv $TMPFILE $OUTPUT.mkv

    ffmpeg -i $OUTPUT.mkv $OUTPUT.webm      # Convert to webm
    mpv $OUTPUT.webm 
}

#convert_to_gif(){
    #notify-send 'Generating gif'
    #ffmpeg -y -i "$TMPFILE"  -vf fps=10,palettegen /tmp/palette.png
    #notify-send 'Generating palette'
    #ffmpeg -i "$TMPFILE" -i /tmp/palette.png -filter_complex "paletteuse" $OUTPUT.gif
    #notify-send "size $(du -h $OUTPUT.gif | awk '{print $1}')"
    #mpv $OUTPUT.gif
    #trap "rm -f '$TMPFILE'" 0
#}

main(){
  record
  #convert_to_gif
}

export -f record main convert_to_gif
$TERMINAL -e bash -c main
