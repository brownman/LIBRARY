dialog_sleep_test(){
echo manual change title
    dialog_sleep 120 'focus on x'
#echo show pid
    dialog_sleep 120 
    }
dialog_sleep () 
{ 
    
#args
local str_caller="`caller`"
    local sec=${1:-60};

    local str="${2:-sleeping}";
    echo 1>&2 print warning "[caller] $str_caller"

#vars

#parse text
    local min=$((sec/60));
    local title="$min m"
    local text="$str";


    echo 1>&2 print ok "[ dialog_sleep ] ${sec}s";
#    /bin/sleep 3
#echo "pid3: $$"
    local num=0;
    { 

#echo "pid4: $$"

    for ((c=1; c<=$sec; c++ ))
    do
        num=$((c*100/sec));
        echo "$num";
        /bin/sleep 1s;
        #resolution_x=${resolution_x:-800}
    done } | yad --progress --percentage=10 --progress-text="$text" --title="$title" --sticky --on-top --auto-close --geometry 100x50+0+0 --no-buttons
    res=$?
    echo "res: $res"
}


#export -f dialog_sleep
dialog_sleep "${1:-60}" "${2:-ZZzz}"

