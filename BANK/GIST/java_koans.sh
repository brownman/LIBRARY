
steps(){
reset

set -o nounset
#set -e 
#set -x
level=beginner

dir=$dir_root/SUBMODULE/java-koans1/koans
dir_level=$dir_root/SUBMODULE/java-koans1/koans/src/${level}

assert dir_exist "$dir"
assert dir_exist "$dir_level"

pushd "$dir" >/dev/null
echo "[pwd] $PWD "
rm1 /tmp/err
./run.sh 2>/tmp/err | tee /tmp/out  &

#| tee /tmp/out 
pid=$!
sleep 1 
# ( dialog_optional 'kill process? ' ) && ( kill -s SIGHUP $pid ;) || echo 
 kbd1 Q
xdotool key Return 
sleep 2



#cat1 /tmp/err  true
file=$( eval "grep -m1 -o /home.*\.java /tmp/out --color=auto" )
num=$( cat /tmp/out | grep -o Line.[1-9]* | sed 's/Line //g' )
( assert file_exist $file &>/dev/null )  && ( assert is_number $num &>/dev/null )

res=$?
indicator "$res"
local next_koan=$( cat /tmp/out | grep 'Remaining Suites' | cut -d' ' -f3 )


xcowsay "$file: $num :  $next_koan "


if [ $res -eq 0 ];then
cmd="gvim $file +${num}"
#indicator
#egrep -v '^[[:space:]]*$' /tmp/out 

#( dialog_optional 'edit recent .java ?')  && ( commander $cmd ) || echo
#( dialog_optional 'edit file' )  && ( gvim "$cmd" )
kbd1 "$cmd"
else
 #   (    dialog_optional 'edit dir' )  && ( gvim $dir_level )
cmd="gvim $dir_level"
 kbd1 "$cmd"
 
fi


popd >/dev/null 

}

gxmessage1 /tmp/err
set +e
( steps )

