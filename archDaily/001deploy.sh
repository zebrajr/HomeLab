clear

# Change keyboard layout to DE
loadkeys de-latin1

# Change Timezone to Berlin
# #[TODO] Should be asked from user
timedatectl set-timezone Europe/Berlin
timedatectl set-ntp true

fdisk -l

echo "Enter disk to be used "
echo "Eg: /dev/vda"
read disk

# Create the Paritions
fdisk ${disk} < fdisk_cmds

# Format parition and prepares swap
mkfs.ext4 ${disk}2
mkswap ${disk}1

# Mount the boot partition
mount ${disk}2 /mnt

# Enable SWAP
swapon ${disk}1


# Install Essential Packages
pacstrap /mnt base linux linux-firmware


# Generate fstab file
genfstab -U /mnt >> /mnt/etc/fstab
# Chroot
arch-chroot /mnt
# Set timezone
# #[TODO] Should be asked from user
ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime
# Generate /etc/adjtime
hwclock --systohc

# Generate Locales
locale-gen

# Create locale.conf and set LANG Variable
echo "LANG=en_US.UTF-8" > /etc/locale.conf

# Set Keyboard Layout
echo "KEYMAP=de-latin1" > /etc/vconsole.conf
