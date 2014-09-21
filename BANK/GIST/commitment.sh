

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
use print
use exiting
use_sh string_to_buttons
#use trap_err
#$cmd_trap_err
#print error use yad instead
#exiting
intro_motivation(){
  xcowsay 'describe your wish - what you want to get'  &

    sleep .6
  xcowsay '+ what u do for others!! on suspension' &

    sleep .6
    xcowsay 'practicing' &

    sleep .4
    xcowsay 'time estimation' &
    sleep .4
  xcowsay 'peace of cake'
}

ext(){
word=$( exec 2>/dev/null    $builtin_string_to_buttons $line )
test -n "$word" && ( commander        pipe_translate $word ) || trace
}

#$cmd_trap_err
#$cmd_trap_exit
#$cmd_trap_err

#set -e
set_sleep(){
    if [ "$delay" -ne 0 ];then
      dialog_sleep  "$delay" "$line"
    fi
min=$( dialog_scale 'Estimate duration (m)' )
test -n "$min" || { exiting;  }
eval "let 'delay = 60 * $min'"
t
}
steps(){
set_env
local line=$( update_commitment ) 
set_sleep
ouch $file_done


}
set_env(){
file_done=/tmp/done
commander assert file_exist "$file_done"
}

steps
