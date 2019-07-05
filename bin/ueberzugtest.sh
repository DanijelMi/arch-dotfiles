#!/usr/bin/env bash
source "`ueberzug library`"

# process substitution example:
ImageLayer 0< <(
    ImageLayer::add [identifier]="example0" [x]="0" [y]="0" [path]="/home/dane/.config/neofetch/main.png"
#     ImageLayer::add [identifier]="example1" [x]="10" [y]="0" [path]="/home/dane/.config/neofetch/main.png"
    sleep 3
    # ImageLayer::remove [identifier]="example0"
#     sleep 5
)

# group commands example:
# {
#     ImageLayer::add [identifier]="example0" [x]="0" [y]="0" [path]="/home/dane/.config/neofetch/main.png"
    # ImageLayer::add [identifier]="example1" [x]="10" [y]="0" [path]="/home/dane/.config/neofetch/main.png"
#     read
#     sleep 2
#     ImageLayer::remove [identifier]="example0"
#     read
# } | ImageLayer