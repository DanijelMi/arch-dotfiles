#!/usr/bin/env sh
# Author: Danijel Milosevic
# Case device connected
if echo info | bluetoothctl | grep -q 'Device' ; then
  echo "%{F#2193ff}"
  exit 0
fi

# Case powered on
if bluetoothctl show | grep -q "Powered: yes" ; then
  #echo "%{F#ffffffff}"
  echo
  exit 0
fi

# Print "blank" to overwrite old output
echo
