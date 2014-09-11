source /tmp/library.cfg
use vars
use dialog_menu
use where_am_i

confirm_gui(){
    local str="$1"
local     cmd=$( gxmessage -entrytext "$str" -title confirm 'continue ?' $GXMESSAGE )
str=$( eval "$cmd" )
res=$?
}

step1(){

local dir_self=`where_am_i`
local file_list=$dir_self/list.txt 
#    local str=$( cat $file_list | yad --list --column='example' --text=Advance.Bash.Scripting  --print-column=1 )
local str=$( dialog_menu_echo $file_list )
    if [ -n "$str" ];then

local res=$?
echo $str
echo $res
local file="$dir_self/BANK/$str"
local cmd="gvim $file"
#confirm_gui "$cmd"
use dialog_confirm 
dialog_confirm 'edit file' "$cmd"
else
    echo "[skip]  choosing a row"
    fi
echo yad --help-list
}
step1
