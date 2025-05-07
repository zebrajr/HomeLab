#!/bin/bash

flag_install=false

if [ "$SETUP_WORKSTATION" == "true" ]; then
    flag_install=true
fi
if [ "$SETUP_VPS" == "true" ]; then
    flag_install=true
fi

if [ "$flag_install" != true ]; then
    echo "${SKIPPING_PRE_TEXT} docker. SETUP_WORKSTATION and SETUP_VPS are both not true"
    return 0
fi

echo "${INSTALLING_PRE_TEXT} docker, docker-compose"
eval "sudo dnf install docker docker-compose -y $OUTPUT_CONTROL"
