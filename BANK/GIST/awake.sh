#!/bin/bash
#depend: pm_utils
#info: awake is auto suspension

timeout1=${1:-60}
util=/usr/sbin/rtcwake
cmd="sudo $util -m mem -s $timeout1"
sleep 4

awake01(){
  use timing
    timing "$cmd" "$timeout1"
    echo "$cmd"
   sleep 4
    #&& firefox
}

awake01
