#options: show / reset / steps(default)
set -o nounset
round_up(){
    let 'count += 1'
    echo "$count" > $file_count

#    dialog_optional "motivation" "xcowsayfortune1" ---> mv it to the pipe

}

set_env(){
    file_count=$dir_workspace/count

}

validate(){
    #validate file
    [ ! -f $file_count ] && { echo 0 > $file_count; }
    #validate content

    count=`cat  $file_count`
    re='^[0-9]+$'
    if ! [[ $count =~ $re ]] ; then
        echo "error: Not a number" >&2; { rm $file_count; exit 1; }
    fi
}

reset(){
    rm1 $file_count 
    $0
}
show(){
    notify-send "round" "X $count"
    toilet1 "$count"

}


steps(){
  #  echo "${FUNCNAME[@]}"
   # echo `caller`
    case $option in
        reset)

            set_env
            reset;
            ;;
        show)

            set_env

           validate 
            show
            ;;
        up)

            set_env

            validate
            round_up
            show
            ;;
    esac

}
if [ $# -eq 0 ];then
echo "[Options] reset / show / up"
else
option=$1
steps
fi

