#!/usr/bin/env bash
# Author: Danijel Milosevic
# Initial menu command 

LOCK_CMD="glitch-lock"  # This is a custom lock screen script
SHUTDOWN_CMD="systemctl poweroff"
REBOOT_CMD="systemctl reboot"
SUSPEND_CMD="systemctl suspend"
HIBERNATE_CMD="systemctl hibernate"

confirm_prompt() {
    CONFIRM_SCRIPT="rofi -dmenu -i -p Confirm -width 13 -lines 1 -columns -2"
    CONFIRM_OPTIONS="Yes\nNo"
    CONFIRM_SELECTION=`echo -e $CONFIRM_OPTIONS | $CONFIRM_SCRIPT | awk '{print $1}'`
    if [ "$CONFIRM_SELECTION" == "Yes" ]; then
        return 0
    else
        return 1
    fi
}
# List and format all menu options
MAIN_OPTIONS=(Lock Shutdown Reboot Suspend Hibernate)
for i in "${MAIN_OPTIONS[@]}"; do
    WORD+=$i\\n
done
MAIN_OPTIONS=${WORD::-2} # trim last \n
unset WORD
MAIN_GUI="rofi -dmenu -i -p Power Options -width 14 -lines ${#MAIN_OPTIONS[@]} -columns 1"

# Check dependencies
DEPENDENCIES=(
      rofi
      )
for i in "${DEPENDENCIES[@]}"; do
   which $i &> /dev/null || printf "$i was not found on your system.\n"
done

# Call of the initial menu 
MAIN_SELECTION=`echo -e $MAIN_OPTIONS | $MAIN_GUI # | awk '{print $1}'`
if [ ${#MAIN_SELECTION} -gt 0 ]; then # non-null selection
    case $MAIN_SELECTION in
        Shutdown)
            confirm_prompt && $SHUTDOWN_CMD
            ;;
        Reboot)
            confirm_prompt && $REBOOT_CMD
            ;;
        Lock)
            $LOCK_CMD
            ;;
        Suspend)
            $SUSPEND_CMD
            ;;
        Hibernate)
            confirm_prompt && $HIBERNATE_CMD
            ;;
        *)
            ;;
        esac
fi
