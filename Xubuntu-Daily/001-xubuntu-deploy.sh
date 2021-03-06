start=`date +%s`
source secrets.cfg
echo "Setting Hostname..."
sudo hostname ${clienthostname}
echo "Adding Repositories..."
sudo add-apt-repository ppa:xubuntu-dev/extras -y &> ${PWD}/001.log
echo "Updating and Upgrading..."
sudo apt update -y &> /dev/null
sudo apt upgrade -y &> /dev/null
echo "Installing: htops, kvm and it's utilities..."
sudo apt install htop -y &> /dev/null
sudo apt install qemu-kvm -y &> /dev/null
sudo apt install virt-manager -y &> /dev/null &&
sudo apt install libvirt-daemon-system -y &> /dev/null &&
sudo apt install libvirt-clients -y &> /dev/null &&
sudo apt install bridge-utils -y &> /dev/null&&
echo "Adding user < ${USER} > to VM groups..."
sudo adduser ${USER} libvirt
sudo adduser ${USER} kvm
echo "Installing OpenVPN & Git & NFS Tools"
sudo apt install git -y &> /dev/null
sudo apt install openvpn -y &> /dev/null &&
sudo apt install network-manager-openvpn -y &> /dev/null
sudo apt install nfs-common -y &> /dev/null
echo "Installing Q.O.L. - Eg: HotCorners..."
sudo apt install xfdashboard -y &> /dev/null
echo "Removing Bloatware..."
sudo apt remove gnome-mines -y &> /dev/null &&
sudo apt remove sgt-launcher -y &> /dev/null &&
sudo apt remove transmission-gtk -y &> /dev/null &&
sudo apt remove parole -y &> /dev/null &&
sudo apt remove WebBrowser -y &> /dev/null &&
echo "Configuring Git to User < ${gituser} >"
git config --global user.name ${gituser}
git config --global user.email ${gitemail}
echo "Cleaning Up"
sudo apt auto-remove -y &> /dev/null
end=`date +%s`
runtime=$((end-start))
echo "Total Run Time: ${runtime} Seconds."
