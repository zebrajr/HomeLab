clear

start=`date +%s`
source secrets.cfg

echo "::  Adding Atom, Cryptomator, Opera to thrusted sources"
wget -q https://packagecloud.io/AtomEditor/atom/gpgkey -O- | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main"
sudo add-apt-repository ppa:sebastian-stenzel/cryptomator
wget -qO- https://deb.opera.com/archive.key | sudo apt-key add -
sudo add-apt-repository "deb [arch=i386,amd64] https://deb.opera.com/opera-stable/ stable non-free"


clear
echo "::  Updating and Upgrading"
sudo apt update -y &> /dev/null
sudo apt upgrade -y &> /dev/null

echo "::  Installing common dependencies"
sudo apt install software-properties-common apt-transport-https wget -y &> /dev/null


echo "::  Installing Atom, Keepass2, Notepadqq, Remmina"
sudo apt install atom -y &> /dev/null
sudo apt install keepass2 -y &> /dev/null
sudo apt install notepadqq -y &> /dev/null
sudo apt install remmina -y &> /dev/null

echo "::  Installing keepass2 utilities"
sudo apt install xdotool -y &> /dev/null

echo "::  Installing Cryptomator, Opera Browser, gparted"
sudo apt install cryptomator -y &> /dev/null
sudo apt install opera-stable -y &> /dev/null
sudo apt install gparted -y &> /dev/null

echo "::  Installing docker, docker-compose and Ansible"
sudo apt install docker -y &> /dev/null
sudo apt install docker-compose -y &> /dev/null
sudo apt install ansible -y &> /dev/null

echo "::  Installing htops, kvm and it's utilities"
sudo apt install htop -y &> /dev/null
sudo apt install qemu-kvm -y &> /dev/null
sudo apt install virt-manager -y &> /dev/null
sudo apt install libvirt-daemon-system -y &> /dev/null
sudo apt install libvirt-clients -y &> /dev/null
sudo apt install bridge-utils -y &> /dev/null

echo "::  Installing gnome-control-center"
sudo apt install gnome-control-center gnome-online-accounts


echo "::  Adding user < ${USER} > to VM groups and docker"
sudo adduser ${USER} libvirt
sudo adduser ${USER} kvm
sudo gpasswd -a ${USER} docker

echo "::  Installing MS Fonts"
sudo apt install ttf-mscorefonts-installer

echo "::  Removing Bloatware"
sudo apt remove gnome-mines -y &> /dev/null
sudo apt remove sgt-launcher -y &> /dev/null
sudo apt remove transmission-gtk -y &> /dev/null
sudo apt remove parole -y &> /dev/null
sudo apt remove WebBrowser -y &> /dev/null
sudo apt remove pidgin -y &> /dev/null
sudo apt remove thunderbird -y &> /dev/null

echo "::  Cleaning Up"
sudo apt auto-remove -y &> /dev/null

end=`date +%s`
runtime=$((end-start))
echo ":: Total Run Time: ${runtime} Seconds."
