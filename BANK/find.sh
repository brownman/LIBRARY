pushd `dirname $0` >/dev/null

#exec 2> >( tee /tmp/err )
#>&2 )

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

search_string(){
#find -iname "$str" .

local file_rel
local cmd


local result=1
local file_rel_target=/tmp/target
local cmd='cat $file_rel_target | grep \/${str}.${type} -m1'
echo 1>&2 "[CMD] $cmd"
file_rel=$( set -o pipefail; eval "$cmd" 2>/dev/null ) 
result=$?
if [ $result -eq 0 ];then
  if [ -n "$file_rel" ];then
    file_found="$dir_self/$file_rel";
    echo 1>&2 "finder: found file: $file_found"
    echo  $file_found
  else
    echo 1>&2 "[ERROR] file is listed but nou found: $file_rel_target";
    echo 1>&2 "[TIP] run: updatedb1"
  fi
else
  echo 1>&2 "[ERROR] target $file_rel_target has no string: $str";
fi
exit $result
}
search_string


popd > /dev/null
