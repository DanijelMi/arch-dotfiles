#!/usr/bin/env bash
#DanijelM
SCRIPT="rofi -dmenu -i -p Power Options -width 10 -lines 5"
OPTIONS="Lock\nShutdown\nReboot\nSuspend\nHibernate"
CONFIRMSCRIPT="rofi -dmenu -i -p Confirm -width 8 -lines 2"
CONFIRMOPTIONS="Yes\nNo"
if [ ${#1} -gt 0 ]; then
    OPTIONS="Exit WM\n$OPTIONS"
fi
SELECTION=`echo -e $OPTIONS | $SCRIPT | awk '{print $1}'`

if [ ${#SELECTION} -gt 0 ]
then
    
    if [ $SELECTION = "Shutdown" ] || [ $SELECTION = "Reboot" ]
    then
        CONFIRMSELECTION=`echo -e $CONFIRMOPTIONS | $CONFIRMSCRIPT | awk '{print $1}'`
        if [ $CONFIRMSELECTION = "Yes" ]
        then
            case $SELECTION in
                Shutdown)
                    systemctl poweroff
                    ;;
                Reboot)
                    systemctl reboot
                    ;;
                *)
                    ;;
            esac
        fi
    else
        case $SELECTION  in
            Exit)
                eval $1
                ;;
            Lock)
                loginctl lock-session
                ;;
            Suspend)
                systemctl suspend
                ;;
            Hibernate)
                systemctl hibernate
                ;;
            *)
                ;;
        esac
    fi
fi
