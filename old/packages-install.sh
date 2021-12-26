#!/usr/bin/bash

# Uses the bottom of the script as data for pacman to install packages
# - is a pipe input for pacman, feeding everything from the script from the point of ##LIST PACKAGES..
# Then remove all lines starting with #
# Then remove everything after # in each line, along with spaces before it
# Then remove all spaces before the end of the line
# TODO: add support for AUR packages via yay
# AUR PACKAGES:
# corrupter-git       # Candied lock screen 
# betterlockscreen    # Candied lock screen
# fusuma              # Touchpad gestures support
# barrier             # fork of Synergy, virtual Keyboard+Mouse switch

pacman -Syy  # Update mirrors
sed -n '/^#*LIST PACKAGES FROM HERE ONWARDS.*$/,$p' $(realpath $0) | \
    sed -e "/^#/d" \
    -e "s/ *#.*//" \
    -e "s/ *$//"| \
    sudo pacman -S --needed - 
exit 0

##LIST PACKAGES FROM HERE ONWARDS
base
base-devel
firefox
networkmanager
tar         # Archiving tool
pigz        # Multi-threading compression algorithm
borg        # Tool for data backup with deduplication support
iw          # Network interface monitoring
rofi        # Program launcher, switcher, replacement to dmenu
fzf         # Fuzzy file finder
fasd        # Frecency-based terminal navigation
mpd         # Music player server daemon
mpc         # CLI interface for mpd
ncmpcpp     # MPD client
alacritty   # Terminal emulator
lightdm                 # Display/login manager
lightdm-slick-greeter   # Graphical style for lightdm
thunar      # Lightweight graphical file manager
vifm        # Ranger alternative
ffmpegthumbnailer   # Lightweight video thumbnailer for file managers
poppler     # pdf previews
w3m         # Text based web browser and pager
python-ueberzug # Aims to replace shitty w3m
neovim      # Vim but better
pycharm-community-edition     # IDE for python
slop        # Small tool for screen-selection
tesseract-data-eng  # OCR tool
transmission-qt     # Torrent Client
transmission-cli    # Torrent Client
tmux        # Must-have
htop
bashtop     # System stats dashboard
ksysguard
gparted     # Graphical storage formatter
mplayer
smplayer    # Lightweight media player
xorg-xbacklight     # Adds control of backlight
nm-connection-editor    # GUI for NetworkManager connections
zathura             # Document reader
zathura-pdf-mupdf   # Dependency for viewing PDFS, EPUBS, there are other alternatives
nethogs     # See which processes are consuming network resources
nfs-utils   # For NFS mounting
samba       # For SMB client/server
remmina     # Remote system control (RDP,VNC,SPICE,NX,XDMCP,SSH)
freerdp     # RDP support for remmina
bluez       # Provides Bluetooth protocol stack
bluez-utils # Gives bluetoothctl cli tool
yay         # AUR package installer
tig         # TUI git
scrot       # CLI screenshot tool
flameshot   # Lightshot linux equivalent
go          # For building go-lang based projects
ttf-dejavu      # font
ttf-dejavu-sans-mono-powerline 
ttf-font-awesome    # Needed for vifm icons
ttf-droid       # font
noto-fonts
noto-fonts-emoji
stress          # lightweight cpu stresstesting tool
libreoffice-fresh # Office suite
code            # Visual Studio Code
sxiv            # Suckless image viewer
libinput        # Input configuration
xorg-xinput     # Change touchpad settings during runtime
xorg-xhost      # Manage auth for X server
xorg-xwininfo   # Get info for x various x windows
xorg-xsetroot   # Change title/cursor of root Xwindow
xdotool         # Automation tool
xdg-utils       # includes xdg-screensaver, assists with desktop integration tasks
compton         # X Compositor
i3lock          # Screen locker
youtube-dl      # Get stuff from yt and similar sites
mps-youtube     # CLI youtube player
python          # Python3
ipython         # Interactive python shell
python-pip      # Python package manager
openssh         # SSH server/client
sshfs           # Mount remote ssh directories
fuse            # Mount filesystems in userspace
android-file-transfer   # Android MTP mount with FUSE wrapper
rsync           # Beautiful tool.
rclone          # For online storage services
guetzli         # google lossy image compression
dunst           # Notification server
xorg-xev        # Find symkeys for keyboard
sxhkd           # Hotkey daemon
ncdu            # Storage analyzing TUI
baobab          # Storage usage visualiser
breeze-gtk      # Used theme for GTK
lxappearance    # Used to configure GTK/QT themes
redshift        # F.lux for linux
geoclue         # Used by redshift to get lat/lon for dimming
tlp             # Power Management
tlpui           # GUI frontend for tlp
festival        # TTS engine
xorg-server-xephyr  # Run X-Server inside an X-Server
mlocate         # adds locate
speedcrunch     # The best calculator ever
xclip          # Clipboard manager
keepassxc       # Improved fork of Keepass in Qt5
pinta           # Paint in linux
unclutter       # Hides cursor when idle
recoll          # Full text search tool, including file content
inotify-tools   # I really should be using this more often
wmname          # Used to set "wmname LG3D"
bspwm           # Binary space partition window manager
autofs          # Automatic filesystem/network mounting
xorg-xrandr     # Configure monitors in X
autorandr       # Save and load configurations
arandr          # GUI frontend for xrandr
nitrogen        # Set desktop wallpaper
python-pywal    # Set color-scheme based on an image
x11vnc          # VNC Server
tint2           # status bar
polybar         # status bar
lemonpanel      # DIY status bar
wireguard-tools # Wireguard VPN serv/client
wireguard-dkms  # Wireguard VPN serv/client
