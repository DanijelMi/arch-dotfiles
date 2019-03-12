#!/bin/bash

#Configure time
timedatectl set-ntp 1
timedatectl set-timezone Europe/Belgrade
timedatectl status	# Check if time got applied correctly

# Make 4 partitions:
# boot(/boot kernel + files used for bootstraping)	~250MB
# root(/ holds all programs)				~8GB+
# home(/home holds all user data)			~2GB+
# swap							20-100% of RAM

# Make a partition
fdisk -l	# check existing partitions
fdisk /dev/sdX	#
	o 	# create a new empty DOS partition table
	n	# add new partition
	p	# make it primary
	enter	# default partition number
	enter 	# default first sector
	+10GiB	# last sector, this sets the size
	#remove signature if existing
	# Do above process 4 times
	a {NUM}	# sets bootable flag, select boot partition
	w 	# writes all changes 

mkswap /dev/sdaX 	# Do this for swap partition
swapon /dev/sdaX	# X is the swap partition

mkfs.ext4 /dev/sdaX	# Do this for other partitions (boot, root, and home)

mount /dev/sdaX /mnt		# X is / (root) partition
mkdir /mnt/home
mkdir /mnt/boot
mount /dev/sdaX /mnt/home	# X is the home partition
mount /dev/sdaX /mnt/boot	# X is the boot partition

pacman -Sy archlinux-keyring
pacstrap /mnt base base-devel networkmanager openssh	# install basic packages into target system before chroot
genfstab -U /mnt >> /mnt/etc/fstab	# generate fstab file
arch-chroot /mnt		# chroot into install target
ln -sf /usr/share/zoneinfo/Europe/Belgrade /etc/localtime	# Set timezone
hwclock --systohc		# generate /etc/adjtime
# Uncomment en_US.UTF-8 UTF-8 and other needed locales in /etc/locale.gen and generate them with: 
locale-gen
# Set the lang variable in /etc/locale.conf accordingly, for example:
echo LANG=en_US.UTF-8 > /etc/locale.conf
echo MYHOSTNAME > /etc/hostname	# Create hostname file
# Add matching entries to /etc/hosts
127.0.0.1	localhost
::1		localhost
127.0.1.1	MYHOSTNAME.localdomain MYHOSTNAME

passwd		# set root password
pacman -S grub
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
exit
umount -R /mnt
reboot
