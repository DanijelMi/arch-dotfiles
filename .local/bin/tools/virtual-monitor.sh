#!/usr/bin/env bash
# Author: Danijel Milosevic
# Creates a virtual screen and hosts a vnc session on top of it.
# Used for creating artificial "monitors" over the network


# MANUAL COMMAND SEQUENCE

# DETERMINE settings for --newmode
#gtf  1080 2160 60   

# Add resolution
#xrandr --newmode "1280x1024_60.00" 108.88 1280 1360 1496 1712 1024 1025 1028 1060 -HSync +Vsync

# Make it available to the specified "monitor"
#xrandr --addmode VIRTUAL1 1280x1024_60.00

# This step can be configured through arandr
#xrandr --output VIRTUAL1 --mode 1280x1024_60.00 --right-of eDP1

# Launch vnc server
#x11vnc -usepw -forever -nocursorshape -cursor arrow -arrow 1 -allow 192.168.42. -multiptr -clip xinerama2     #(xinerama0/1/2/3/4...)

# AUTOMATIC ATTEMPT

# Using export instead of pure define in order to pass it to a subterminal/subshell
export V_MONITOR="VIRTUAL1"

create_vmon(){
  # Create if the layout doesn't already exist
  echo "Creating layout..."
  xrandr | grep --null-data --quiet "$V_MONITOR.*480x960_60" || { \
  xrandr --newmode $(gtf 480 960 60 | tail -n2 | head -n1 | sed 's/^.*Modeline "/"/g') && \
  xrandr --addmode $V_MONITOR $(gtf 480 960 60 | tail -n2 | head -n1 | awk '{print $2}') ; }

  # Create if the layout doesn't already exist
  echo "Creating layout..."
  xrandr | grep --null-data --quiet "$V_MONITOR.*960x480_60" || { \
  xrandr --newmode $(gtf 960 480 60 | tail -n2 | head -n1 | sed 's/^.*Modeline "/"/g') && \
  xrandr --addmode $V_MONITOR $(gtf 960 480 60 | tail -n2 | head -n1 | awk '{print $2}') ; }

  #xrandr --output $V_MONITOR --auto    # Places the screen in overlap, not recommended. Use the command below instead

  echo "Activating virtual layout..."
  # If layout exists, activate the virtual monitor and place it relative to an existing monitor
  xrandr | grep --null-data --quiet "$V_MONITOR.*960x480_60" && \
  xrandr --output $V_MONITOR --mode $(gtf 960 480 60 | tail -n2 | head -n1 | awk '{print $2}') --below eDP1

  # Create a vnc session if one doesn't exist and bind it to the "$V_MONITOR" monitor
  echo "Creating a VNC server..."
  sleep 2
  xrandr | grep --quiet "$V_MONITOR connected" && { \
  pgrep x11vnc >/dev/null || \ 
  #x11vnc -usepw -forever -nocursorshape -cursor arrow -arrow 1 -allow 192.168.42. -multiptr -clip xinerama$(xrandr --listmonitors | grep "$V_MONITOR" | cut -c2-2) ; }
  x11vnc -forever -nocursorshape -cursor arrow -arrow 1 -multiptr -clip xinerama$(xrandr --listmonitors | grep "$V_MONITOR" | cut -c2-2) ; }
}

# Exporting the function for use in the subterminal/subshell
export -f create_vmon

$TERMINAL -e bash -c create_vmon

#Huawei mate 10 lite screen: 1080 x 2160 (18:9)

# 288x144 (144p)
# 480x240 (240p)
# 720x360 (360p)
# 960x480 (480p)
# 1440x720 (720p HD)
# 1536x768 (768p)
# 1800x900 (900p)
# 2100x1050 (1050p)
# 2160x1080 (1080p FHD)
