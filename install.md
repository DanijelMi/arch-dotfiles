# Installation guide - short


## Vmware
To enable EFI on vmware player, create VM normally, then once created, 
modify VMX file and include the following line:
firmware = "efi"

## First shell
https://wiki.archlinux.org/title/Installation_guide
- Check conectivity and DNS
- Confirm you are on efi by confirming this path exists `/sys/firmware/efi/efivars`
- Partition:
  fdisk -l
  parted -a optimal --script /dev/disk_to_partition \
    mklabel gpt \
    mkpart "efi" fat32 1MiB 301MiB \
    set 1 esp on \
    mkpart "root" ext4 301MiB '100%'

mkfs.fat -F32 /dev/sda1
mkfs.ext4 /dev/sda2

mount /dev/sda2 /mnt
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot

pacstrap /mnt base linux linux-firmware 
genfstab -U /mnt >> /mnt/etc/fstab
(inspect /mnt/etc/fstab)
arch-chroot /mnt
ln -sf /usr/share/zoneinfo/Region/City /etc/localtime
hwclock --systohc
pacman -S --noconfirm nvim
nvim /etc/locale.gen  -  uncomment en_US.UTF-8 UTF-8
locale-gen
echo darch > /etc/hostname
passwd

pacman -S --noconfirm grub efibootmgr networkmanager network-manager-applet wpa_supplicant dialog os-prober base-devel linux-headers reflector
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager

useradd -mG wheel dane
passwd dane

visudo   -    uncomment # %wheel ALL=(ALL) ALL

umount -a
reboot

login into new system
shut down vm
remove instalation iso cd from VM
Enter VM again
sudo systemctl enable --now NetworkManager

## Some packages

sudo pacman -S --noconfirm neovim tmux

## Graphic environment bspwm
sudo pacman -S --noconfirm libxcb xcb-util xcb-util-wm xcb-util-keysyms sxhkd bspwm xorg xorg-xinit rofi arandr alacritty xwallpaper xdo wmname xscreensaver
supply dotfiles for bspwm and sxhkd
make bspwmrc executable
launch bspwn through .xinitrc with startx

sudo pacman -S --noconfirm gtkmm gtkmm3 gtk2
sudo pacman -S --noconfirm xf86-input-vmmouse xf86-video-vmware mesa
sudo pacman -S --noconfire libnotify dunst redshift rofi tint2 nitrogen
sudo pacman -S --noconfirm speedcrunch

## dev
sudo pacman -S --noconfirm code docker docker-compose terraform ansible git
systemctl start docker
sudo usermod -aG docker $USER

## openssh
sudo pacman -S --noconfirm openssh
Create new or add existing SSH keys

## File
sudo pacman -S --noconfirm leafpad pcmanfm-qt gvfs
sudo pacman -S --noconfirm lxappearance
sudo pacman -S --noconfirm arc-icon-theme arc-gtk-theme pop-gtk-theme   # Themes used by gtk2 and gtk3 configs
yay -S fontmatrix


## misc
sudo pacman -S --noconfirm conky unclutter htop nodejs xdotool xclip youtube-dl bc
sudo pacman -S --noconfirm signal-desktop discord viber wireguard-tools ddcutil
yay -S ferdi viber

## Web
sudo pacman -S --noconfirm firefox chromium

## Vmware
sudo pacman -S --noconfirm open-vm-tools
systemctl enable --now vmtoolsd.service
systemctl enable --now vmware-vmblock-fuse.service
if not using display manager, add to .xinitrc `vmware-user-suid-wrapper &` before `exec bspwm`
NTP:
vmware-toolbox-cmd timesync enable

## Vscode
Download pkgbuild https://aur.archlinux.org/packages/visual-studio-code-bin/
extract tar.gz
makepkg -si

## Keyring
https://github.com/MicrosoftDocs/live-share/issues/224
sudo pacman -S --noconfirm gnome-keyring libsecret

## Symlinking:
dunst
bspwm
alacritty
nvim
redshift
sxhkd
zathura
rofi
picom
conky
fontconfig
polybar

.bashrc
.alias_fn
.profile > .bash_profile
.xinitrc

.local/bin
.local/wallpaper

~/.gtkrc-2.0
~/.config/gtk-3.0/settings.ini

## PDF
sudo pacman -S --noconfirm zathura zathura-pdf-mupdf

## Audio
sudo pacman -S  pulseaudio pulseaudio-alsa pulseaudio-equalizer pamixer alsa pavucontrol alsa-utils
open pavucontrol, tweak settings
reboot
??? profit

## Compositor
sudo yay -S picom picom-conf

## Partition stuff
sudo pacman -S fuse ntfs-3g parted gparted
yay -S unetbootin

## Clipboard/screenshot
sudo pacman -S flameshot

## GPU AMD
/etc/pacman.conf
uncomment core extra community multilib
sudo pacman -Syu
sudo pacman -S --needed lib32-mesa vulkan-radeon lib32-vulkan-radeon vulkan-icd-loader lib32-vulkan-icd-loader
sudo pacman -S steam
sudo pacman -S xf86-video-amdgpu mesa lib32-mesa
sudo pacman -S amdvlk
sudo pacman -S lib32-fontconfig ttf-liberation wqy-zenhei

## Media
sudo pacman -S --noconfirm mpv vlc
