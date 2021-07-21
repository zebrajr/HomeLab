clear
start=`date +%s`

echo "::  Updating and Upgrading"
sudo apt update -y &> /dev/null
sudo apt upgrade -y &> /dev/null


echo "::  Installing: Steam, Audacious, VLC"
sudo apt install steam -y &> /dev/null
sudo apt install audacious -y &> /dev/null
sudo apt install vlc -y &> /dev/null

echo "::  Installing: Handbrake, ffmpeg"
sudo apt install handbrake -y &> /dev/null
sudo apt install ffmpeg -y &> /dev/null

echo "::  Cleaning Up"
sudo apt autoclean -y &> /dev/null
sudo apt auto-remove -y &> /dev/null

end=`date +%s`
runtime=$((end-start))
echo ":: Total Run Time: ${runtime} Seconds."
