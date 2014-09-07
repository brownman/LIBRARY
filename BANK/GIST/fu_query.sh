

#echo $0
sleep 1
pushd `dirname $0` >/dev/null

GXMESSAGE2="-ontop -sticky -timeout 20"
set -o nounset
set_env(){
    file_html=/tmp/snippet.html
    file_snippet=/tmp/snippet
}
cleanup(){
    [ -f $file_snippet ] && rm $file_snippet
}
dialog(){
    str_input=$( gxmessage -entrytext "$str_input" -title "Add Snippet" "Any new Question ?" $GXMESSAGE2 )
}
generate_file(){
#    fu_cmd "$str_input"
local str=$1
local file_backup=/tmp/snippet_$str





#until [[ -z $str ]]; do
    echo -e "\n# $str {{{1" >> $file_snippet;
    curl -L -s "commandlinefu.com/commands/matching/$str/`echo -n $str|base64`/plaintext" | sed '1,2d;s/^#.*/& {{{2/g' | tee -a $file_snippet > $file_snippet.c;
    sed -i "s/^# $str {/# $str - `grep -c '^#' $file_snippet.c` {/" $file_snippet;
    #shift;
#done;

cp  $file_snippet $file_backup
}

present_in_browser(){

commander "$BROWSER $file_html"
}
convert_to_html(){
    pushd /tmp>/dev/null
vim -X -e -f +"syn on" +"TOhtml" +"wq" +"q" "$file_snippet"
    popd >/dev/null
}

present_in_gvim(){

cmd="gvim -u /dev/null -c \"set ft=sh fdm=marker fdl=1 noswf\" -M $file_snippet" 
eval "$cmd"
#| xsel --clipboard;
#rm $file_snippet $file_snippet.c

}

steps(){
set_env
cleanup
dialog
[ -n $str_input ] && generate_file $str_input || exit
#[ -f $file_snippet ] &&  present_in_gvim || exit
[ -f $file_snippet ] && convert_to_html 
[ -f $file_html ] &&  present_in_browser

}
str_input="${1:-}"
steps
popd >/dev/null
#fu_cmd () 
#{ 
#    curl "http://www.commandlinefu.com/commands/matching/$@/$(echo -n $@ | openssl base64)/plaintext"
#}

