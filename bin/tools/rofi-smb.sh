#!/usr/bin/env bash
# Author: Danijel Milosevic
# Dependencies: rofi
# Acts like a main menu for navigating all other
# custom scripts in the same directory as this file
authenticate(){
    # If user is root or sudo still remembers password
    if [  $(echo $EUID) -eq 0 ] || sudo -n true 2>/dev/null; then
        sudo "$@"
    else
        PASSWD=$(rofi -dmenu -i -password -p "Requires Privileges" -width 30 -lines 0)
        if [ ${#PASSWD} -gt 0 ]; then
            echo $PASSWD | sudo -S "$@"
        fi
    fi
}
authenticate && mount -t cifs -o credentials=/home/dane/.smbcreds,uid=dane //192.168.1.102/Dane /mnt/NAS-Dane