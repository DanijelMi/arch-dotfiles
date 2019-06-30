#!/usr/bin/bash

# Uses the bottom of the script as data for pacman to install packages
# - is a pipe input for pacman, feeding everything from the script from the point of ##LIST PACKAGES..
# Then remove all lines starting with #
# Then remove everything after # in each line, along with spaces before it
# Then remove all spaces before the end of the line
# TODO: add support for AUR packages via yay
# YAY PACKAGES:
# corrupter-git
# betterlockscreen
# st-luke-git
pacman -Syy  # Update mirrors
sed -n '/^#*LIST PACKAGES FROM HERE ONWARDS.*$/,$p' $(realpath $0) | \
    sed -e "/^#/d" \
    -e "s/ *#.*//" \
    -e "s/ *$//"| \
    sudo pacman -S --needed --noconfirm - 
exit 0

##LIST PACKAGES FROM HERE ONWARDS
base
base-devel
firefox
networkmanager
iw          # Network interface monitoring
rofi        # Program launcher, switcher, replacement to dmenu
mpd         # Music player server daemon
ncmpcpp     # MPD client
st          # Suckless terminal
awesome     # Window manager
lightdm     # Display/login manager
lightdm-slick-greeter	# Graphical style for lightdm
moka-icon-theme     # For slick-greeter
adapta-maia-theme   # For slick-greeter
pcmanfm     # Lightweigh graphical file manager
vifm        # Ranger alternative
ffmpegthumbnailer   # Lightweight video thumbnailer for file managers
poppler     # pdf previews
atool       # Universal archive extraction/preview in ranger
w3m         # Text based web browser and pager
python-ueberzug # Aims to replace shitty w3m
neovim      # Vim but better
pycharm-community-edition     # IDE for python
transmission-qt     # Torrent Client
transmission-cli    # Torrent client
tmux        # Terminal multiplexer
gparted     # Graphical storage formatter
smplayer    # Lightweight media player
xorg-xbacklight     # Adds control of backlight
nm-connection-editor    # GUI for NetworkManager connections
zathura             # Document reader
zathura-pdf-mupdf   # Dependency for viewing PDFS, EPUBS, there are other alternatives
nfs-utils   # For NFS mounting
samba       # For SMB client/server
remmina     # Remote system control (RDP,VNC,SPICE,NX,XDMCP,SSH)
freerdp     # RDP support for remmina
yay         # AUR package installer
tig         # TUI git
scrot       # CLI screenshot tool
flameshot   # Lightshot linux equivalent
go          # For building go-lang based projects
ttf-hack        # font
ttf-dejavu      # font
ttf-droid       # font
ttf-inconsolata # font
ttf-liberation  # font
stress          # very lightweight cpu stresstesting tool
code            # Visual Studio Code
sxiv            # Suckless image viewer
libinput        # Input configuration
xorg-xinput     # change touchpad settings during runtime
xorg-xhost      # Manage auth for X server
fzf             # Fuzzy file finder
i3lock          # Screen locker
youtube-dl      # Get stuff from yt and similar sites
mps-youtube     # CLI youtube player
python          # Python3
ipython         # Interactive python shell, good as calculator
python-pip      # Python package manager
openssh         # SSH server/client
sshfs           # Mount remote ssh directories
fuse            # Mount filesystems in userspace
android-file-transfer   # Android MTP mount with FUSE wrapper
rsync           # Beautiful tool.
rclone          # For online storage services
dunst           # Notification server
qtile           # Experimental
xorg-xev        # See keybinds for sxhkd
sxhkd           # Hotkey daemon
ncdu            # Storage analyzing TUI
xwallpaper      # Minimalistic wallpaper setter
breeze-gtk      # Used theme for GTK
lxappearance    # Used to configure GTK/QT themes
redshift        # F.lux for linux
geoclue         # Used by redshift to get lat/lon for dimming
xorg-server-xephyr  # Run X-Server inside an X application
mlocate         # adds locate
speedcrunch     # The best calculator ever
clipit          # Clipboard manager
keepassxc       # Improved fork of Keepass in Qt5
unclutter       # Hides cursor when idle
recoll          # Full text search tool, including file content