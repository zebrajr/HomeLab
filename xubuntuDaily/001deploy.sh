start=`date +%s`
source secrets.cfg

echo "::  Updating and Upgrading"
sudo apt update -y &> /dev/null
sudo apt upgrade -y &> /dev/null

echo "::  Installing common dependencies"
sudo apt install software-properties-common apt-transport-https wget -y &> /dev/null

echo "::  Adding Atom to trusthed sources"
wget -q https://packagecloud.io/AtomEditor/atom/gpgkey -O- | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main"

echo "::  Installing Atom"
sudo apt install atom -y &> /dev/null



end=`date +%s`

runtime=$((end-start))
echo "Total Run Time: ${runtime} Seconds."
