use dialog_menu
use where_am_i
use commander 

run(){
local dir_self=$( where_am_i $0 )
local file_list=$dir_self/list.txt

local str=$( dialog_menu_echo $file_list )
local cmd="gvim $dir_self/BANK/$str"
commander "$cmd"
}
run
