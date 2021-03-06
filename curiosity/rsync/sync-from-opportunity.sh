#!/bin/bash

# Don't forget to add the script to anacron for automatic sync
# sudo nano /etc/anacrontab
# Run Every Day / If not executed wait 15 minutes after system boot / Unique Name / Script Location
# 1  15  syncFromOpportunity.daily  /bin/sh /home/rsync/sync-from-opportunity.sh

. ./home/rsync/config.sh



rsync --progress -avz -e "ssh -i ${SOURCEKEY}" $TARGETUSER@$TARGETIP:$TARGETFOLDER $SOURCEFOLDER
