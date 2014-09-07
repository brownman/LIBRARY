step1(){
#ENV
set -o nounset
#set -x
#set -e

#LOCATION
local dir_self="`where_am_i $0`"
local filename=script.sh
local file=$dir_self/${filename}
local util='bash -c'

#COMMAND
local cmd="$util $file"
echo $cmd
eval "$cmd"
}
step1
