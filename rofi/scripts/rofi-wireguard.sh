#!/usr/bin/env bash
# Author: Danijel Milosevic
# Dependencies: Rofi

# Set vi as editor if no editor is set
[ -z "$EDITOR" ] && EDITOR=vi   

# Where the wireguard connection parameters are stored
CONFIG_PATH="/etc/wireguard/*.conf"

# Executes a privileged command and requests authentication if needed
authenticate(){
    # Is the process owner root? Or is sudo already typed in?
    if [ $(id -u) = 0 ] || sudo -n true 2>/dev/null ; then
        sudo "$@"
    else    # Get password from rofi for sudo
        PASSWD=$(rofi -dmenu -i -async-pre-read 0 -password -p "Requires Privileges" -width 30 -lines 0)
        if [ ${#PASSWD} -gt 0 ]; then
            echo $PASSWD | sudo -S "$@"
            unset PASSWD    # """Security"""
        fi
    fi
}
# Checks if wireguard is on/off
WG_STATUS=$(ip addr | grep wg0 | awk '{print$1}')
if [ ${#WG_STATUS} -gt 0 ]; then    # If entry found
    WG_STATUS="Active"
    OPTIONS=(Deactivate Restart Configure)
else
    WG_STATUS="Inactive"
    OPTIONS=(Activate Configure)
fi
for i in "${OPTIONS[@]}"; do
    OPTIONS_FORMATTED+=$i\\n
done
OPTIONS=${OPTIONS_FORMATTED::-2} # trim last \n
SCRIPT="rofi -dmenu -i -p $WG_STATUS -width 20 -lines ${#OPTIONS[@]}"

# Display main menu
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
            # List and format all files from $CONFIG_PATH
            FILE=`authenticate bash -c "ls $CONFIG_PATH"`
            for f in $FILE; do
                AP="$(basename -- $f)\n$AP"
            done
        CONFIG_SELECTION=`echo -e ${AP%??} | rofi -dmenu -i -lines ${#AP[@]} -p "Config File"`
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
# CHECK END CASES
