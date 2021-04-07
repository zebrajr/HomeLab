clear
start=`date +%s`
source secrets.cfg

echo "::  Adding Atom to thrusted sources"
wget -q https://packagecloud.io/AtomEditor/atom/gpgkey -O- | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main"

echo "::  Updating and Upgrading"
sudo apt update -y &> /dev/null
sudo apt upgrade -y &> /dev/null

echo "::  Installing common dependencies"
sudo apt install software-properties-common apt-transport-https wget -y &> /dev/null

echo "::  Installing Atom, Keepass2, Notepadqq"
sudo apt install atom -y &> /dev/null
sudo apt install keepass2 -y &> /dev/null
sudo apt install notepadqq -y  &> /dev/null

echo "::  Installing: htops, kvm and it's utilities..."
sudo apt install htop -y &> /dev/null
sudo apt install qemu-kvm -y &> /dev/null
sudo apt install virt-manager -y &> /dev/null
sudo apt install libvirt-daemon-system -y &> /dev/null
sudo apt install libvirt-clients -y &> /dev/null
sudo apt install bridge-utils -y &> /dev/null

echo "Adding user < ${USER} > to VM groups..."
sudo adduser ${USER} libvirt
sudo adduser ${USER} kvm

echo "::  Removing Bloatware..."
sudo apt remove gnome-mines -y &> /dev/null
sudo apt remove sgt-launcher -y &> /dev/null
sudo apt remove transmission-gtk -y &> /dev/null
sudo apt remove parole -y &> /dev/null
sudo apt remove WebBrowser -y &> /dev/null

echo "::  Cleaning Up"
sudo apt auto-remove -y &> /dev/null

end=`date +%s`
runtime=$((end-start))
echo ":: Total Run Time: ${runtime} Seconds."
