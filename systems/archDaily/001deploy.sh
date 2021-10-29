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

echo "New Hostname? "
echo "Eg: bsa200arch"
read newhostname
echo "Local Domain?"
echo "Eg: local"
read newdomain
echo "Main User?"
echo "Eg: csa"
read newuser
echo "Main User Password?"
read userPassword
echo "root password?"
read rootPassword
# read newuserid
# echo "cryptsetup (LVM) password?"
# read pass

#echo "set a password for root "
#passwd


# Create the Partitions (and LVM if UEFI mode)
fdisk ${disk} < fdisk_cmds
#gdisk ${disk} < gdisk_cmds

# Format EFI Partition
mkfs.fat -F32 ${disk}1

# Format the boot partition
mkfs.ext4 ${disk}2

# Set Up Encryption
# [TODO] Add automatic password deployment
cryptsetup luksFormat ${disk}3 -q -d -
cryptsetup open --type luks ${disk}3 lvm

# Set up LVM
pvcreate --dataalignment 1m /dev/mapper/lvm
vgcreate volgroup0 /dev/mapper/lvm
# [TODO] Add / and /home logical volumes
# lvcreate -l 30GB volgroup0 -n lv_root
lvcreate -l 100%FREE volgroup0 -n lv_root
modprobe dm_mod
vgscan
vgchange -ay


# Format root partition
mkfs.ext4 /dev/volgroup0/lv_root &> ${LOGLOCATION}
# Mount the root partition
mount /dev/volgroup0/lv_root /mnt &> ${LOGLOCATION}

# Create boot partition mount point
mkdir /mnt/boot
# Mount Boot Partition
mount ${disk}2 /mnt/boot

# Format home partition
#mkfs.ext4 /dev/volgroup0/lv_home &> ${LOGLOCATION}

# Create home partition mounting point
# mkdir /mnt/home

# Mount the home volume
#mount /dev/volgroup0/lv_home /mnt/home &> ${LOGLOCATION}

#Create the /etc directory
mkdir /mnt/etc

# Create the /etc/fstab file
genfstab -U -p /mnt >> /mnt/etc/fstab

# Install Essential Packages
pacstrap /mnt base

# Access Arch Installation
arch-chroot /mnt

# Install Kernel and Headers
pacman -S linux linux-lts linux-headers linux-lts-headers --noconfirm

# Install Nano
pacman -S nano --noconfirm

# Install Optional Packages
pacman -S base-devel openssh --noconfirm

# Enable OpenSSH
systemctl enable sshd

# Install networking packages
pacman -S networkmanager wpa_supplicant wireless_tools netctl --noconfirm

# Install Dialog (Required for wifi-menu)
pacman -S dialog --noconfirm

# Enable networkmanager
systemctl enable NetworkManager

# Add LVM support
pacman -S lvm2 --noconfirm

# Adds "encrypt lvm2" to mkinitcpio.conf to support lvm2 and encryption
sed -i 's/modconf block/modconf block encrypt lvm2/g' /etc/mkinitcpio.conf

# Create Initial ramdisk for main kernel
mkinitcpio -p linux

# Create initial LTS kernel ramdisk
mkinitcpio -p linux-lts

# Sets Locale
echo "LANG=en_US.UTF-8" > /mnt/etc/locale.conf
locale-gen

# Change Root Password
usermod -p ${rootPassword} root

# Adds user
useradd -m -g users -G wheel ${newuser}

# Sets user password
usermod -p ${userPassword} csa

# Install sudo
pacman -S sudo --noconfirm

# Allow "wheel" group to use sudo
echo '%wheel ALL=(ALL:ALL) ALL' | sudo EDITOR='tee -a' visudo

# Install GRUB
pacman -S grub efibootmgr dosfstools os-prober mtools --noconfirm

# Create EFI directory
mkdir /boot/EFI

# Mount EFI Partition
mount ${disk}1 /boot/EFI

# Install GRUB
#grub-install --target=x86_64-efi --bootloader-id=grub_uefi --recheck



































#
#
#
# # Set TimeZone
# arch-chroot /mnt timedatectl set-timezone Europe/Berlin
#
# # Set Keyboard Layout
# echo "KEYMAP=de-latin1" > /mnt/etc/vconsole.conf
#
# # Generate the new locales
# arch-chroot /mnt locale-gen
#
# # Setting hostname
# echo ${newhostname} > /mnt/etc/hostname
#
# # Adding entries to hosts(5)
# echo "127.0.0.1	localhost" >> /mnt/etc/hosts
# echo "::1		localhost" >> /mnt/etc/hosts
# echo "127.0.1.1	${newhostname}.${newdomain}	${newhostname}" >> /mnt/etc/hosts
#
# systemctl enable dhcpcd
# arch-chroot /mnt passwd
#
# # Install Grub Bootloader
# arch-chroot /mnt pacman -Sy grub os-prober --noconfirm -q
# arch-chroot /mnt grub-install ${disk}
# arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg
