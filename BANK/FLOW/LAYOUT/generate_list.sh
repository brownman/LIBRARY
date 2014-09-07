#present: 
#set -x 
#set -e


generate_list(){

set -o nounset
    #    $dir_library/LAYOUT/genereate_list.sh
    #set +e
    #set -o pipefail
    #ls -1 $dir_target/*/*.* 1>$file_target
    #/tmp/err

    #    local prefix="$1"
    local file_target=/tmp/target
    echo 1>&2 "file target: $file_target"
    #ls -1 ${prefix}.{conf,cfg,sh,yaml,txt}
    #local types="yaml,txt,cfg,sh,1st,0st"
    local types=$( echo $types | sed 's/ /,/g' )
        local cmd="ls -1 $dir_CODE/*/*.{$types,}"
    echo "$cmd"
    eval "$cmd" 1>$file_target 
    #2>/tmp/err || { cat /tmp/err; }

echo "[TYPES] $types"
    cat -n $file_target
    echo "$file_target"

    cat "$file_target" | wc -l
   # print_line

    #print_line
set +o nounset

}

generate_list
