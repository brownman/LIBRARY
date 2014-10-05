#!/bin/bash
# about file:
# string to buttons -> choose -> echo -> say

#http://www.thegeekstuff.com/2010/06/bash-array-tutorial/
#clear
source /tmp/library.cfg

using(){
  use assert
  use trace
  use exiting
  use vars
  use print
  use commander
}

str_to_arr_and_update_line(){
  test -v arr
  local str="$@" 
  local delimeter 
( echo "$str" | grep '-'  &>/dev/null ) && { delimeter=','; } || { delimeter=' '; }
print color 33 "[ delimeter]  _${delimeter}_"
  old_IFS=$IFS
  IFS="$delimeter"
line="Q${delimeter}$str"
print color 33  "[line] $line "
  arr=($(echo "$line" ))
  IFS=$old_IFS
}

arr_to_str(){
 local str1="$@"
  local item=''
  local item1=''
  for i in "${!arr[@]}"; do
    item=${arr[$i]}
    item1=$(remove_trailing "$item")
    if [ "$str1" = '' ];then
      str1="$item:$i"
    else
      str1="$str1,$item:$i"
    fi
  done
  echo "$str1"
}



trace1(){
  print color 34 [trace] $@
}
remove_trailing(){
  local str_res=$(echo "$@" | sed -e 's/^ *//g' -e 's/ *$//g')
  echo $str_res
  #http://stackoverflow.com/questions/369758/how-to-trim-whitespace-from-bash-variable
}


arr_to_msg(){
  set -u
  print func
  local num str
  local str_buttons="$@"

  str='GENIUS ! '
  #$(random_line $file_assosiation)
  str=$( gxmessage -buttons "$str_buttons" "$str" $GXMESSAGE_T  2>/dev/null )
  #echo str $str
  #gxmessage -print - will print the label
  num=$?
  return $num
}




set_env(){
declare -a arr
arr=()

using
assert string_has_content "$line"
}

steps(){

#assert left_bigger $# 0 


str_to_arr_and_update_line "$line"
trace arr: ${arr[@]}
trace arr: ${#arr[@]}

str_buttons=$( arr_to_str ) #use array to create buttons-string
trace $str_buttons
( arr_to_msg $str_buttons )
num=$?
trace num: $num
trace arr: ${arr[$num]}

str_res="${arr[$num]}"
trace RES:
if [ "$str_res" != Q ];then
  echo $str_res
else 
  print color 36 skipping 
fi
}

line="${@:-}"
set_env
str_res=$( steps )
remove_trailing $str_res

#print color 33 _${str_res}_ 
#echo -n $str_res
