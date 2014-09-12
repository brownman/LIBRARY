pushd `dirname $0` >/dev/null

exec 2> >( tee /tmp/err >&2 )

[ $# -gt 0 ] || { echo 1>&2 'no args'; exit 1; }

#set -x 
set -u
#set +e


dir_self=$PWD
str=$1
type=${2:-cfg}


intro(){
echo 1>&2 $dir_self
echo 1>&2 $str
}

validate(){
test -f ./updatedb.sh || { echo 1>&2 file not exist:./updatedb.sh ; exit; }
file_rel_target=/tmp/target
[  -f $file_rel_target ] && ( echo 1>&2 "file exist: $file_rel_target";  ) || ( echo 1>&2 file not exist: $file_rel_target; ./updatedb.sh ) 
}

search_string(){
#find -iname "$str" .

local file_rel
local cmd="cat $file_rel_target | grep \/${str}.${type} -m1"
echo 1>&2 "[CMD] $cmd"

file_rel=$( eval "$cmd" 2>/dev/null ) 
result=$?
if [ $result -eq 0 ];then
  if [ -f "$file_rel" ];then
    file_found="$dir_self/$file_rel";
    echo  $file_found
    result=0
  else
    echo 1>&2 "[ERROR] file is listed but nou found: $file_rel";
    echo 1>&2 "[TIP] run: updatedb1"
  fi
else
  echo 1>&2 "[ERROR] target file_rel has no string: $str";
  
fi

}
steps(){
validate
search_string
}

result=1
steps
exit $result

popd > /dev/null
