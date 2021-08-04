#!/bin/bash

arch-chroot /mnt pacman -Sy curl \
                            htop \
                            tmux \
                            --noconfirm -q
