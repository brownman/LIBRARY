
#sleep 5

#depend: yad gxmessage
#info: make a commitment - write it down.
#set -e
#set -x
set -o nounset
#set -e

use vars
use assert
use flite1
use pipe_translate
use file_update
use dialog_scale
use dialog_sleep
use dialog_add_line
use print
use exiting
use_sh string_to_buttons
#use trap_err
#$cmd_trap_err
#print error use yad instead
#exiting
set_env(){
#commander ensure touch $file_done

touch $file_done
commander assert file_exist "$file_done"
}


intro_motivation(){
cat << FILE
describe your wish - what you want to get  
+ what u do for others!! on suspension 
practicing 
time estimation 
peace of cake
FILE
echo
}

ext(){
local line="$1"
sleep 5
word=$( exec 2>/dev/null    $builtin_string_to_buttons $line )
test -n "$word" && ( commander        pipe_translate $word ) 
}

#$cmd_trap_err
#$cmd_trap_exit
#$cmd_trap_err

#set -e
set_sleep(){
local delay="${1:-60}"
local min=$( dialog_scale 'Estimate duration (m)' )
test -n "$min" || { exiting;  }
let "delay = 60 * $min"
echo $delay
}

steps(){
set_env
set -e
set -u
local line_recent=''
test -s $file_done && { set -o pipe_fail; line_recent=$(cat $file_done | tail -1 | cut -d' ' -f2- ); }
print color 33 line_recent $line_recent
#exiting 
sleep 1
local line=$( dialog_add_line $file_done  "$line_recent" ) 
local num=$( set_sleep )

ext "$line"  &
dialog_sleep $num "$line"

}



delay=${1:-60}
file_done=/tmp/done
steps
