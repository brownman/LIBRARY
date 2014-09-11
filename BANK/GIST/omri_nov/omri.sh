use where_am_i
use commander 
use vars
use assert
use dialog_menu
use dialog_confirm

assert util_exist tree

run(){
  local dir_self=$( where_am_i $0)
  local dir_prefix="$dir_self/BANK"
  local file_list=`mktemp`
ls -1 $dir_self/BANK > $file_list
local str=$(  dialog_menu_echo $file_list  )
dialog_confirm open "thunar $dir_self/BANK/$str" &
}

run
