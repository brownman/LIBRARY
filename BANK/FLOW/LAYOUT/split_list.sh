split_list(){
    #IFS=',' 
    local file_target="${1:-/tmp/target}"
    #cmd="eval echo \"split_part $file_target ${types}\""
    #echo "[ cmd ] $cmd"
    for type in $types;do
        eval "split_part $file_target $type"
    done

}

split_part(){
    set +e
    local file_target="$1"
    local str="$2"
    local flag_confirm=${3:-false}

    local cmd=''
    # assert file_target_exist "$file_target"
    local file_target_out="/tmp/sourced_${str}"
    touch $file_target_out
    #  add_symlink $file_target_out
    #mv1 $file_target_out ${file_target_out}.old
    cat $file_target | grep "${str}$" > $file_target_out
    echo "$file_target_out"
    cat "$file_target_out" | wc -l
}
#export -f split_list
#export -f split_part
split_list
