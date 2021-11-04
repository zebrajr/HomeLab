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
    read -t1 -n1 check
    clear
    if [[ $check == "p" ]];then
        echo "!! Paused !!"
        read -n1
        check=""
    fi
    echo $2
    echo "$secs Seconds to go"
    secs=$[secs-1]
  done
}

clear
while true
do
  for counter in {1..3}
  do
    displayMessage $worktime "Work Work Work!"
    if [[ $counter -ne 3 ]];
    then
      displayMessage $shorttime "Chilling Quickly"
    fi
  done
  displayMessage $longtime "Resting..."
done
exit 0
