#!/bin/bash

# 25  minutes = 1500
# 20  minutes = 1200
# 5   minutes = 300

worktime=1500
shorttime=300
longtime=1200


displayMessage(){
  notify-send -i "${PWD}/rsc/pomodoro.png" "Pomodoro Timer" "$2"
  secs=$1
  while [[ 0 -ne $secs ]]
  do
    echo $2
    echo "$secs Seconds to go"
    sleep 1
    secs=$[secs-1]
    clear
  done
}

clear
while true
do
  for counter in {1..3}
  do
    displayMessage $worktime "Work Work Work!"
    displayMessage $shorttime "Chilling Quickly"
  done
  displayMessage $longtime "Resting..."
done
exit 0
