#!/usr/bin/env bash
# Author: Danijel Milosevic
BT_DEVICE_MAC="$@"
if [ $# -eq 0 ] ; then 
    echo "MAC Address is required as argument" 
    exit 1
fi
BT_NAME="$(bluetoothctl info $BT_DEVICE_MAC | grep -Po 'Name: \K.*')"
# If device already connected, disconnect
if bluetoothctl info $BT_DEVICE_MAC | grep 'Connected: yes' ; then
    notify-send "Trying to disconnect $BT_NAME"
    bluetoothctl disconnect $BT_DEVICE_MAC && \
    notify-send "Disconnecting $BT_NAME Successful"
    exit 0
fi

notify-send "Trying to connect to $BT_NAME"
bluetoothctl connect $BT_DEVICE_MAC && \
notify-send "$BT_NAME Connection Successful"