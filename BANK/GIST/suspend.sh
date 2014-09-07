#!/bin/bash 
#about file:
#plugin:        suspend
#info:          suspend the computer
#depend: pm-utils
#description:   suspend the computer + limit powering-on to X seconds

set -e
set -o nounset

#source /tmp/cfgs
set_env(){
util=/usr/bin/pm-suspend
cmd="sudo $util"
timeout1=${1:-60}
}

#!/bin/bash
#depend: pm_utils
#info: suspend is auto suspension


#util=/usr/sbin/rtcwake
#cmd="sudo $util -m mem -s $timeout1"


suspend01(){
   timing "$cmd" "$timeout1"
    echo "$cmd"
    sleep 4
    #&& firefox
}
set_env
suspend01
