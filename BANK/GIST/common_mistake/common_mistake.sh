#!/bin/bash
set -u
set -o nounset
use commander
use vars
use indicator
use where_am_i
#use dialog_menu

#https://github.com/koalaman/shellcheck/wiki/_pages
#echo $0
#echo $BASH_SOURCE
sleep 2
#dir_self=`dirname   "$BASH_SOURCE"`
dir_self=$( where_am_i $0 )
source $dir_self/dialog_multiple.cfg
url="https://github.com/koalaman/shellcheck/wiki"

steps(){
  #    source $dir_self/random.cfg


  #num=`wc -l $dir_self/tags.txt | cut -d' ' -f1`
  #random $num
  #choose=$?
  #echo "random line: $choose "
  #local suffix=$(        cat "$dir_self/tags.txt" | head -${choose} | tail -1 )
local file suffix res

  file=$dir_self/tags.txt
  suffix=$( dialog_menu_multiple  $file )
  res=$?
  indicator $res
  local str="$url/$suffix"
  echo "$str"
  #sleep 3
  #eval "xdg-open $str"
  test $res -eq 0 && ( eval "$BROWSER '$str'" )

}

steps


set +o nounset
