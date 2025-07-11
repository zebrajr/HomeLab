#!/bin/bash

########################
# Missing ohmyzsh
########################

clear

# Set variable holding the Debian version codename
DEBIAN_VERSION="bookworm"
DOCKER_USER="docker-user"
SYSTEM_HOSTNAME="vps02.carlossousa.tech"
SSH_PUBLIC_KEY="ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDW0ryhGvQwtXEQvP2+RV4PanS+TahMTj98WQqH0Dpe8 contabo-vps-m-me@carlosousa.tech"


# Create custom_sources file with deb and deb-src entries
cat <<EOF > /etc/apt/sources.list.d/custom_sources.list
# Main
deb http://deb.debian.org/debian/ $DEBIAN_VERSION main contrib non-free
deb-src http://deb.debian.org/debian/ $DEBIAN_VERSION main contrib non-free

# Security
#deb http://deb.debian.org/debian/ ${DEBIAN_VERSION}-security main contrib non-free
#deb-src http://deb.debian.org/debian/ ${DEBIAN_VERSION}-security main contrib non-free

# Backports
deb http://deb.debian.org/debian/ ${DEBIAN_VERSION}-backports main contrib non-free
deb-src http://deb.debian.org/debian/ ${DEBIAN_VERSION}-backports main contrib non-free

# Updates
deb http://deb.debian.org/debian/ ${DEBIAN_VERSION}-updates main contrib non-free
deb-src http://deb.debian.org/debian/ ${DEBIAN_VERSION}-updates main contrib non-free

# Sid (the Unstable Distribution)
deb http://deb.debian.org/debian/ sid main
deb-src http://deb.debian.org/debian/ sid main
EOF


cat <<EOF > /etc/apt/preferences.d/custom_preferences
# Package pinning to prefer stable, then unstable, then testing

# Stable packages get the highest priority
Package: *
Pin: release a=stable
Pin-Priority: 900

# Unstable packages get medium priority
Package: *
Pin: release a=unstable
Pin-Priority: 600

# Testing packages get the lowest priority
Package: *
Pin: release a=testing
Pin-Priority: 300
EOF

# Stop script if any command returns a non-zero status
set -e


# Set Hostname
hostnamectl set-hostname "$SYSTEM_HOSTNAME"


# Check for updates and update the system using apt
apt update -y
apt upgrade -y


# Info: if some package can't be installed due to missing dependencies (eg: package is from unstable, but stable has a lower dependency version only)
#   apt install -t unstable <dependency>

# Install Packages
apt install \
    btop \
    curl \
    docker \
    docker-compose \
    duf \
    fail2ban \
    fastfetch \
    fzf \
    git \
    ncdu \
    neovim \
    rsync \
    sudo \
    tmux \
    vim \
    wget \
    zsh \
    -y

# Docker Setup
if ! getent group docker > /dev/null 2>&1; then
  groupadd docker
fi

if ! id "$DOCKER_USER" > /dev/null 2>&1; then
  useradd -m "$DOCKER_USER"
fi

su -c "mkdir -p /home/$DOCKER_USER/.ssh" - $DOCKER_USER
su -c "chmod 700 /home/$DOCKER_USER/.ssh" - $DOCKER_USER

auth_keys="/home/$DOCKER_USER/.ssh/authorized_keys"
su -c "touch $auth_keys" - $DOCKER_USER
su -c "cat <<EOF > $auth_keys
$SSH_PUBLIC_KEY
EOF
" - $DOCKER_USER

su -c "chmod 600 $auth_keys" - $DOCKER_USER


usermod -aG docker "$DOCKER_USER"
usermod -aG sudo "$DOCKER_USER"

# Fail2Ban Setup
cat <<EOF > /etc/fail2ban/fail2ban.local
[DEFAULT]
allowipv6 = auto
EOF

cat <<EOF > /etc/fail2ban/jail.local
[DEFAULT]
# Debian 12 has no log files, needs to use journalctl
backend = systemd

# Configure nftables
banaction = nftables-multiport
chain = input
banaction_allports = nftables[type=allports]

# Regular Banning
bantime = 24h
findtime = 600
maxretry = 5

bantime.increment = true
bantime.rndtime = 30m


dbpurgeage = 30d

[sshd]
enabled = true
mode = aggressive
backend = systemd
maxretry = 5
EOF

cat <<EOF > /etc/ssh/sshd_config.d/99-custom-hardening.conf
PermitRootLogin no
MaxAuthTries 3
Protocol 2
PermitEmptyPasswords no
PasswordAuthentication no
AuthenticationMethods publickey
StrictModes yes
EOF

systemctl start fail2ban
systemctl enable fail2ban
systemctl restart sshd

# Clean system
apt autoremove -y


# Show status of fail2ban service
echo -e "\n\n\n\n\n\n\n\n\n\n"
echo "=================================="
echo "==== fail2ban service status ===="
echo "=================================="
echo
systemctl status fail2ban --no-pager

echo -e "\n\n\n"
# Show information about the user stored in DOCKER_USER variable
if [ -z "$DOCKER_USER" ]; then
    echo "DOCKER_USER variable is not set."
else
    echo "=================================="
    echo "==== Information for user: $DOCKER_USER ===="
    echo "=================================="
    echo
    id "$DOCKER_USER" || echo "User $DOCKER_USER not found."
    echo
fi

