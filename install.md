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
sudo pacman -S --noconfirm libxcb xcb-util xcb-util-wm xcb-util-keysyms sxhkd bspwm xorg xorg-init rofi arandr
supply dotfiles for bspwm and sxhkd
make bspwmrc executable
launch bspwn through .xinitrc with startx

sudo pacman -S --noconfirm gtkmm gtkmm3 gtk2
sudo pacman -S --noconfirm xf86-input-vmmouse xf86-video-vmware mesa
sudo pacman -S --noconfirm dunst redshift rofi

## openssh
sudo pacman -S --noconfirm openssh
Create new or add existing SSH keys

## dev
sudo pacman -S --noconfirm git

## misc
sudo pacman -S --noconfirm htop leafpad pcmanfm-qt

## Web
sudo pacman -S --noconfirm firefox

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

.bashrc
.alias_fn
.profile > .bash_profile
.xinitrc

## PDF
sudo pacman -S --noconfirm zathura zathura-pdf-mupdf










