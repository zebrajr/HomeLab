#!/bin/bash
find /mnt/hdd/DL/DL/Clips/ ! -type d > /mnt/hdd/DL/DL/Scripts/files.txt
sed -i -e "s/mnt/file '\/mnt/gi" /mnt/hdd/DL/DL/Scripts/files.txt
sed -i -e "s/\/file/file/gi" /mnt/hdd/DL/DL/Scripts/files.txt
sed -i -e "s/.mkv/.mkv'/gi" /mnt/hdd/DL/DL/Scripts/files.txt
ffmpeg -f concat -safe 0 -i /mnt/hdd/DL/DL/Scripts/files.txt -c copy /mnt/hdd/DL/DL/Scripts/output.mkv
