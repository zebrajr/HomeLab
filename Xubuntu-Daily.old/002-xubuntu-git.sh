source secrets.cfg
echo "Creating Directories"
mkdir ~/GitHub &> log002.log
cd ~/GitHub &> log002.log
echo "Cloning Repos..."
git clone ${gitrepo001} &> log002.log
git clone ${gitrepo002} &> log002.log
