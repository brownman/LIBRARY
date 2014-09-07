#!/bin/bash
#set -x
#set -e
set -o nounset
source /tmp/library.cfg
use vars
#options: update list with a string or commands: exit / delete
#info: file update using a gui dialog box

#path=`dirname $0`
#pushd "$path">/dev/null
secs=27

subject=${1:-general_subject}
dir_tmp=/tmp
#$dir_workspace/lists/txt/
file=/tmp/$subject.txt
file_tmp=/tmp/list_$subject.tmp.txt
[ ! -f $file ] && { touch $file; }

msg(){
    local line=''
  #  while [ "$line" = '' ];do
        line=$(gxmessage -file $file -title "$subject"  --timeout $secs -entry $GXMESSAGE )
  #  done

    #[ $MODE_PIPE_TRANSLATE = 0 ] && { pipe_translate "$line"; }
    [ -n "$line" ] && { update_file "$file" "$line" ;}
    if [ "$line" = exit ];then
       return 0 
    fi

}
remove_trailing(){
    echo "$@" tr -s " "
}

update_file(){

    local file=$1
    local line="$2"
    local time_stamp=`date | tr -s " " | cut -d' ' -f4| cut -d':' -f1,2`
    if [ "$line" = delete ];then
        echo -n '' > $file
    elif [ "$line" = exit ];then
        print error "[ kill process?]"
        
        exit 0
    else
        tac $file > $file_tmp
        echo -e "$time_stamp\t$line" >> $file_tmp
        tac $file_tmp > $file
    fi
    echo "$line"
}

run(){
#while :;do
#$builtin_reminder
msg
#done
}
run
#popd>/dev/null
