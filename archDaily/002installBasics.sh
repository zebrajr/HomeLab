#!/bin/bash

arch-chroot /mnt pacman -Sy curl \
                            htop \
                            --noconfirm -q
