

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

update_commitment(){
  set -u
  local line="${line:-}"
  local time1=`date | tr -s ' ' | cut -d' ' -f4 | cut -d':' -f1,2 `
  local cmd=""
  local word=''
  while [ -z "$line" ];do
    #flite1 "it is easy for a robot - what do u want to do lazy boy ?" &
    #next easy mission"

    title="Easy For Robot"
#intro_motivation
    
    cmd="gxmessage -font \"$FONT\" -entrytext \"$line\" -title \"$title\" -file \"$file_done\"  $GXMESSAGE_T_S"
    print color 33 $cmd
#    echo $cmd
    line=$(    eval "$cmd" 2>/dev/null  )
    #break
  done
  if [ "$line" = exit ];then
    xcowsay exiting
    exit 1
  elif [ "$line" = delete ];then
    echo -n '' > $file_done  
    return 0
  else
      #flite -t 'it is easy for me - you are a little monkey' &
    local line_new="$time1\t $line"
    file_update "$file_done" "$line_new"
word=$( exec 2>/dev/null    $builtin_string_to_buttons $line )
test -n "$word" && ( commander        pipe_translate $word )

       #echo  pipe_translate "$word"; 

#echo __${word}_

#echo __${word}_
    if [ "$delay" -ne 0 ];then
      dialog_sleep  "$delay" "$line"
    fi
    echo "$line"
  fi
}

file_done=/tmp/done
min=$( dialog_scale 'Estimate duration (m)')
indicator $?
let "delay=60*$min"
#delay=${1:-60}

touch $file_done
commander assert file_exist "$file_done"
update_commitment

