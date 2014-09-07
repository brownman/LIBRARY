set_env(){
dir_self=`where_am_i $0`
file_target="$dir_root/pilot.sh"
file="$dir_data/XML/rc_${distro}.xml"
}

step1(){
#~/.config/openbox/rc.xml
#commander "ln -sf $file_target /tmp/service.sh"
echo
}

step2(){
assert file_exist "$file"
openbox --reconfigure
}


intro_finish(){
#ls -l $file_target 
echo
#toilet "hotkey"
print color 33 "Install 1 hotkey - For quickly rise the project\'s menu "
echo
echo "[openbox configuration file ] $file"
echo "[key-bindings] for our project's anchor:"
grep_color
cat $file | grep 'anchor' --color=auto -B 2  -A 0 | egrep 'keybind'\|'anchor' --color=auto -A 2
grep_color
cat $file | grep 'riddle.yaml' --color=auto -B 2  -A 0 | egrep 'keybind'\|'riddle' --color=auto -A 2

}


install(){
clear
set_env
#step1
intro_finish
openbox --reconfigure
}
run(){
xcowfortune

}

cmd=${1:-run}
eval "$cmd"
