echo "::  Updating"
start=`date +%s`
sudo apt update -y &> /dev/null &&
echo "::  Upgrading the following:"
sudo apt list --upgradable
sudo apt upgrade -y
echo "::  Removing Old Packages"
sudo apt autoclean -y
sudo apt autoremove -y
end=`date +%s`
runtime=$((end-start))
echo "::  Total Update Time: ${runtime} seconds!"
