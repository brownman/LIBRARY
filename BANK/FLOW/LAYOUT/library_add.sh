# |_   _| |  \/  | |  _ \ 
#   | |   | |\/| | | |_) |
#   | |   | |  | | |  __/ 
#   |_|   |_|  |_| |_| 

set -o nounset 
set -e
set -x
num=$#
args="$@"

[ $num -lt  2 ] && { print error "[got $num] [args:$args] \nneed 2 args: dirname and filename";exit; } 


if [ $# -eq 3 ];then
    shift
fi

   
#dir_self=`where_am_i $0`
file_list_tmp=$dir_library/list_tmp.txt
#NAMING
dirname=$1
filename=$2
filename_short=`echo $filename | cut -d'.' -f1`

#PATH
dir=$dir_library/BANK/$dirname
file=$dir/$filename



#xreate dir/file
[ ! -d $dir ] && { mkdir $dir; }
[ ! -f $file ] && { touch $file; }
#update index
line=$dirname/$filename
echo
cmd="echo '$line' >> $file_list_tmp"
dialog_confirm "$cmd"



#validate
print ok "[list_tmp.txt] new entry added ? "
cat $file_list_tmp | grep "$file" --color=auto 
print ok "[validate] file exist ?"
ls -l $file
print ok "[finish] instructions ?"
echo "[ run ] libraryS  and then  ${filename_short}E - for editing the new file"
