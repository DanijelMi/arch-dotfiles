#!/usr/bin/env bash
# Author: Danijel Milosevic
# Dependencies: rofi
# Acts like a main menu for navigating all other
# custom scripts in the same directory as this file

# Rofi + params
MAIN_GUI="rofi -dmenu -i -p Custom Menu"
# Dir path of this script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# Name of this script
SCRIPT_NAME=`basename "$0"`

# List all files from the script directory excluding itself
SELECTION=$(ls $SCRIPT_DIR -I $SCRIPT_NAME | $MAIN_GUI)
# Execute the selected script
if [ ${#SELECTION} -gt 0 ]; then
    $SCRIPT_DIR/$SELECTION
fi