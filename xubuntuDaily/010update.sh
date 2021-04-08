echo "::  Updating"
start=`date +%s`
sudo apt update -y &> /dev/null &&
echo "::  Upgrading"
sudo apt upgrade -y &> /dev/null &&
echo "::  Removing Old Packages"
sudo apt auto-remove -y &> /dev/null
end=`date +%s`
runtime=$((end-start))
echo "::  Total Update Time: ${runtime} seconds!"
