#!/bin/bash

# 25  minutes = 1500
# 20  minutes = 1200
# 5   minutes = 300

worktime=1500
shorttime=300
longtime=1200



while true
do
  for counter in {1..3}
  do
    notify-send -i "${PWD}/rsc/pomodoro.png" "Pomodoro Timer" "Work Work Work!"
    sleep ${worktime}
    notify-send -i "${PWD}/rsc/pomodoro.png" "Pomodoro Timer" "You earned a small break."
    sleep ${shorttime}
  done
  notify-send -i "${PWD}/rsc/pomodoro.png" "Pomodoro Timer" "Okay, time to rest a bit longer."
  sleep ${longtime}
done
exit 0
