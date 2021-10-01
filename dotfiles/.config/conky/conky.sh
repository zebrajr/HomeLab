#!/bin/bash

while true
do
  running=$(ps -a | grep conky | wc -l)
  if [ $running -lt 3 ];
  then
    echo "Starting..."
    conky -c ~/.config/conky/main.conf &
  fi
  sleep 10
done
