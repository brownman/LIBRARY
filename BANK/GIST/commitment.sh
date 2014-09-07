#depend: yad gxmessage
#info: make a commitment - write it down.
#set -e
#set -x
set -o nounset
use assert
use flite1
use pipe_translate
use file_update
#use trap_err
#$cmd_trap_err

update_commitment(){
  local line="${line:-}"
  local time1=`date | tr -s ' ' | cut -d' ' -f4 | cut -d':' -f1,2 `
  local cmd=""
  export GXMESSAGE='-ontop -sticky -wrap -timeout 10'
  while [ -z "$line" ];do
    flite1 "it is easy for a robot - what do u want to do lazy boy ?"
    #next easy mission"
    title="Easy For Robot"
    cmd="gxmessage -entrytext \"$line\" -title \"$title\" -file \"$file_done\" $GXMESSAGE"

    local     line=$(    eval "$cmd" 2>/dev/null  )
  done
  if [ "$line" = exit ];then
    xcowsay exiting
    exit 1
  elif [ "$line" = delete ];then
    echo -n '' > $file_done  
    return 0
  else
      flite -t 'it is easy for me - you are a little monkey'
    local line_new="$time1\t $line"
    file_update "$file_done" "$line_new"
    (    pipe_translate "$line"; )&
    if [ "$delay" -ne 0 ];then
      dialog_sleep  "$delay" "$line"
    fi
    echo "$line"
  fi
}
intro(){
  xcowsay 'describe your wish - what you want to get'
  xcowsay '+ what u do for others!! on suspension'
}

file_done=/tmp/done
delay=${1:-60}

touch $file_done
assert file_exist "$file_done"
update_commitment

