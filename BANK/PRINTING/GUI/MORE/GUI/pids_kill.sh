#Here is a process killer to select one (or more) pids and kill them:

#!/bin/bash

TMPFILE=/tmp/$$.pstmp OUTFILE=/tmp/$$.psdata EMSG=/tmp/$$.errmsg

gen_data() {

    ps aux | tail -n +2 > $TMPFILE
    cat $TMPFILE | awk -F' ' '{print " " "\n" $1 "\n" $2 "\n" $3 "\n" $4 "\n" $5 "\n" $6 "\n" $7 "\n" $8 "\n" $9 "\n" $10 "\n" $11}' > $OUTFILE
}

while true;do
    gen_data
    selection=$( yad --list \
        --checklist \
        --column=":CHK" \ --column="USER:TXT" \ --column="PID:NUM" \ --column="%CPU:NUM" \ --column="%MEM:NUM" \ --column="VSZ:NUM" \ --column="RSS:NUM" \ --column="TTY:TXT" \ --column="STAT:TXT" \ --column="START:TXT" \ --column="TIME:TXT" \ --column="COMMAND:TXT" \ --multiple \ --width=900 \ --height=600 \ --title="Killer" \ --window-icon="process-stop" \ --button="Kill:0" \ --button="Refresh:1" \ --button="Exit:2" < $OUTFILE)
    sel_ret=$?
    case $sel_ret in
        0)
            echo "$selection" | awk -F'|' '{print $3 " " $12}' | 
            while read pid cmdr;do
            if -n "$pid";then
                zenity --question --text "Confirm kill of pid: $pid\n\nCommand: $cmd" rc=$? 
                if $rc -eq 0;then
                kill -9 $pid 2> $EMSG 
                if $? -ne 0;then
                errmsg="cat $EMSG" zenity --error --text "$errmsg"
            else
                zenity --info --text "Pid $pid killed..." --timeout=1
            fi
        fi
    else
        zenity --info --text "No pid selected..." --timeout=3
    fi
done ;;
#continue ;;
2)
    break ;;
esac
done

rm -f $TMPFILE rm -f $OUTFILE rm -f $EMSG
