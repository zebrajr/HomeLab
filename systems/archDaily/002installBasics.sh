#!/bin/bash

arch-chroot /mnt pacman -Sy curl \
                            htop \
                            tmux \
                            xfce4 \
                            xfwm4 \
                            xfce4-panel \
                            xfce4-terminal \
                            --noconfirm -q
