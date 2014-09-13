#depend: tree 
#type tree &>/dev/null || { echo run the installer first: missing dependencies: tree; exit 1;  }

pushd `dirname $0` >/dev/null


clear


file=/tmp/target
file_prev=/tmp/target_prev
MODE_UPDATE=0

#cmd="tree -if --noreport **/ > $file"
#cmd='ls -1 **/*.* > $file'
cmd='find * -type f | grep -v '.old' >$file'




if [ -f $file ];then
    echo file exist: $file
    echo continue anyway..
    #echo update ?
    #read answer
    answer=y
    test "$answer" = y && { cp $file $file_prev; } || { echo skipping; MODE_UPDATE=1; }
fi

if [ $MODE_UPDATE = 0 ] ;then
    echo "[CMD] $cmd"
    eval "$cmd"
    #sed -i 's_^./__g' $file
    if [ -f $file_prev ];then
        cmp $file $file_prev
        res=$?
        echo "[FILE DIFFERENT ?] $res"
    fi
fi



num=$( cat $file | wc -l )
echo -n "[ $file ] "

echo "[LINES] $num"


popd >/dev/null
