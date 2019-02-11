#!/usr/bin/env bash
# Author: Danijel Milosevic
# Dependencies: Rofi
EDITOR=vim
CONFIG_PATH="/etc/wireguard/*.conf"
howmany() { echo $#; }
howmanyNL() { echo $(howmany ${1//\\n/ }); }
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
WG_STATUS=$(ip addr | grep wg0 | awk '{print$1}')
if [ ${#WG_STATUS} -gt 0 ]; then
    WG_STATUS="Active"
    OPTIONS="Deactivate\nRestart\nConfigure"
else
    WG_STATUS="Inactive"
    OPTIONS="Activate\nConfigure"
fi
SCRIPT="rofi -dmenu -i -p $WG_STATUS -width 20 -lines $(howmanyNL $OPTIONS)"
# Parameters to be displayed
SELECTION=`echo -e $OPTIONS | $SCRIPT | awk '{print$1}'`

if [ ${#SELECTION} -gt 0 ]; then
    case $SELECTION in
        Activate)
            authenticate wg-quick up wg0
            ;;
        Deactivate)
            authenticate wg-quick down wg0
            ;;
        Configure)
            FILE=`authenticate bash -c "ls $CONFIG_PATH"`
            for f in $FILE
            do
                AP="$(basename -- $f)\n$AP"
            done
        CONFIG_SELECTION=`echo -e ${AP%??} | rofi -dmenu -i -lines $(howmanyNL $AP) -p "Config File"`
            if [ ${#CONFIG_SELECTION} -gt 0 ]; then
                authenticate $EDITOR $(dirname $CONFIG_PATH)/$CONFIG_SELECTION
            fi
            ;;
        Restart)
            authenticate wg-quick down wg0
            authenticate wg-quick up wg0
            ;;
    esac
fi


# ADD NOTIF FOR INCORRECT PASS
