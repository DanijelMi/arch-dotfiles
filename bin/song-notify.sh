#!/usr/bin/bash

# Get fields from mpc, split by tabs.
IFS=$'\t' read album artist title \
  <<< "$(mpc --format="%album%\t%artist%\t%title%")"


dunstify -r "21851" --urgency=low -t 2000 --appname=ncmpcpp \
  --icon=audio-x-generic "$album" "$artist\n$title"