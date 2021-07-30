#!/bin/bash
clear
LOGLOCATION=/root/log.txt


echo ":: Change keyboard layout to DE"
loadkeys de-latin1

echo ":: Change Timezone to Berlin"
# #[TODO] Should be asked from user
timedatectl set-timezone Europe/Berlin
timedatectl set-ntp true

fdisk -l

echo ":: Enter disk to be used "
echo ":: Eg: /dev/vda"
read disk

echo "Enter hostname "
echo "Eg: bsa200arch"
read newhostname
echo "Enter domain "
echo "Eg: local"
read newdomain

#echo "set a password for root "
#passwd


# Create the Paritions
fdisk ${disk} < fdisk_cmds
#gdisk ${disk} < gdisk_cmds

# Format parition and prepares swap
mkfs.ext4 ${disk}2 &> ${LOGLOCATION}
mkswap ${disk}1 &> ${LOGLOCATION}

# Mount the Filesystem
mount ${disk}2 /mnt &> ${LOGLOCATION}
swapon ${disk}1 &> ${LOGLOCATION}

# Install Essential Packages
pacstrap /mnt base linux linux-firmware

# Generate the fstab File
genfstab -U /mnt >> /mnt/etc/fstab

# Set TimeZone
arch-chroot /mnt timedatectl set-timezone Europe/Berlin

# Create locale.conf and set LANG Variable
echo "LANG=en_US.UTF-8" > /mnt/etc/locale.conf

# Set Keyboard Layout
echo "KEYMAP=de-latin1" > /mnt/etc/vconsole.conf

# Generate the new locales
arch-chroot /mnt locale-gen

# Setting hostname
echo ${newhostname} > /mnt/etc/hostname

# Adding entries to hosts(5)
echo "127.0.0.1	localhost" >> /mnt/etc/hosts
echo "::1		localhost" >> /mnt/etc/hosts
echo "127.0.1.1	${newhostname}.${newdomain}	${newhostname}" >> /mnt/etc/hosts

systemctl enable dhcpcd
arch-chroot /mnt passwd

# Install Grub Bootloader
arch-chroot /mnt pacman -Sy grub os-prober --noconfirm -q
arch-chroot /mnt grub-install ${disk}
arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg
