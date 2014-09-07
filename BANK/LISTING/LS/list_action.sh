set -o nounset
confirm(){
    local cmd="$@"
    #echo "[confirm] $cmd"
    dialog_confirm "$cmd"
}
prepare_list(){
    ls -1 $dir/*.* > $file
}

list_action(){
    #assert file_exist "$file"
    lines=`cat $file`
    for line in $lines;do
        echo "$line"
        line1=`echo "$cmd"`
        confirm "$line1"
    done <$file
}
#export -f list_action
[ $# -ne 2 ] && { echo -e "help: supply 2 args: \na dir , a cmd"; echo "execute the command on each file of the dir";exit; }
dir="$1"
cmd="$2"

file=/tmp/list
prepare_list "$dir"
list_action  "$cmd"
