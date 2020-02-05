#!/usr/bin/env sh
# Author: Danijel Milosevic
# Case bt connected
if echo info | bluetoothctl | grep -q 'Device' ; then
  echo "%{F#2193ff}"
  exit 0
fi

# Case powered on
if bluetoothctl show | grep -q "Powered: yes" ; then
  echo "%{F#ffffffff}"
  exit 0
fi

# Needed to print "blank" in case when bluetooth is completely off
echo