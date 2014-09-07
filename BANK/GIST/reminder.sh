#!/bin/bash
#depend: yad flite vim-gtk
#info: speak sentences from a list
#set -e
set -o nounset 

#change between false and true - to sound / unsound
set_env(){
sound=${SOUND:-true}
dir_script=`dirname $0`
file=${1:-$dir_workspace/reminder.txt}

( assert file_exist $file ) || { xcowsay1 'write some sentences for increasing your motivation';gvim $file;exiting; }
if [ ! -f $file ];then
    touch $file
    echo "I can do it" > $file
fi
NAME=${NAME:-$LOGNAME}
cmd=${1:-'run'}
}

random_line(){
    #    echo 'random_line()'
    local file="$1"
    if [ -f "$file" ];then
        local line=$( shuf -n 1 $file ) 
        echo "$line"
    else 
        echo 'no such file' "$file"
    fi
}

update_current(){
( yad --notification 'test' --command="gvim $file" --listen --menu 'sdf|abc|df'  --timeout=10 )
}
speak(){
    local line="$1"
    if [ "$line" ];then


        notify-send "$line" & 
        if [ "$sound" = true ];then

            echo "$line" | flite -voice slt &
            sleep 1
            echo "$line" | flite -voice kal &
            sleep 1
            echo "$line" | flite -voice awb &
        else
            msg="sound:" "$sound"
            notify-send "$msg"
        fi

    fi

}
run(){
    update_current &
    echo 'run()'
    local line=$(random_line $file)
    #speak "$NAME"
    #speak "$line"
    pipe_translate_random "$line"
}


random_line(){
    #    echo 'random_line()'
    local file="$1"
#(    random 3 ) && (    dialog_optional 'edit motivations ?' )  && ( gvim "$file" )  
maybe_every 5 update_file $file
    if [ -f "$file" ];then
        local line=$( shuf -n 1 $file ) 
        echo "$line"
    else 
        echo 'no such file' "$file"
    fi
}


set_env
run

