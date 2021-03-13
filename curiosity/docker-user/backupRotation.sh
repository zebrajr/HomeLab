#!/bin/bash

# Don't forget to add the script to anacron for automatic sync
# sudo nano /etc/anacrontab
# Run Every Day / If not executed wait 15 minutes after system boot / Unique Name / Script Location
# 1  15  backupOpportunity.daily  /bin/sh /home/docker-user/backupOpportunity.sh


. /home/docker-user/config.sh
mkdir -p $BACKTO/$(date +%F)
find "$BACKFROM" -maxdepth 1 -mindepth 1 -type d \
    -execdir tar -cf "$BACKTO/$(date +%F)/"{}-$(date +"%Y-%m-%d--%H-%M").tar {} \;

# ls -dt */ | tail -n +11 | xargs rm -rf
