intro(){
clear
}
set_env(){
    dependOn PACKAGE/distro1.cfg
    dependOn PACKAGE/install1.cfg
}

single(){
local file=$1
local file_list=/tmp/list
local method=$2
#list_strip $file $file_list
cat $file | cut -d '#' -f1 > $file_list
act_on_list $file_list $method
}
step1(){
    set -o nounset
single $dir_list/dependencies_all.txt  install1
single $dir_list/dependencies_extra.txt install1
    set +o nounset
single $dir_list/dependencies_python.txt install1_python

    set -o nounset
}

steps(){
    intro
    set_env
    step1
}

steps

