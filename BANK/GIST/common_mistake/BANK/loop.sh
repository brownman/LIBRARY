






set -u
set -e
file_tmp=`mktemp`
file_list=tags3.txt
num=$( cat $file_list | wc -l  )
counter=1

while [  $counter -lt $num ]; do

  cmd="sed -n \"$counter\"p \"$file_list\""

  str=$( eval "$cmd" ) 
  echo -n "$str" >> $file_tmp 
  let "counter=$counter+1"

  cmd="sed -n \"$counter\"p \"$file_list\""
  str=$( eval "$cmd" ) 
  echo "$str" >> $file_tmp 
  let "counter=$counter+1"

  let "counter=$counter+1"
done
cat $file_tmp
