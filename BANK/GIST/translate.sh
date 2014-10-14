#info: translate a string using google scrapping
#depend: wget sox

set -o nounset
#$cmd_trap_err
#trap - ERR
#exec -c
#set -x
#set -e
#set -e
#set -x
trap_err(){
    xcowsay error
  print func
  print error 
$str_caller
exit 0
}
trap trap_err ERR
#export -f trap_err
set_env(){
use vars
  use ensure
  use flite1
  use paplay1
  use broadcast

  MAX_WORDS=30
  MAX_CHARS=400
  export MODE_SOUND=${MODE_SOUND:-true}
  delay_phone=1
 
#  commander $cmd_trap_err
}
#commander depend mpg123
#$cmd_trap_exit

sanitize_string1(){
  local   str="$@"
  local str_clean="${str//[^a-zA-Z0-9 ]/ }"
  echo "$str_clean"

}
sanitize_filename1(){
  #url: http://stackoverflow.com/questions/89609/in-a-bash-script-how-do-i-sanitize-user-input
  local str=$( echo "$@" )

  # first, strip underscores
  local clean=${str#//_/}
  # next, replace spaces with underscores
  clean=${clean// /_}
  # now, clean out anything that's not alphanumeric or an underscore
  clean=${clean//[^a-zA-Z0-9_]/}
  # finally, lowercase with TR
  clean=$( echo -n $clean | tr A-Z a-z )
  echo "$clean"
}
step0(){
  dir_txt=/tmp
  dir_mp3=/tmp
  dir_html=/tmp
}
step1() {
  print ok "input: $input"
  input_wsp=$(echo "$input"|sed 's/ /+/g');
  input_ws=$(echo "$input"|sed 's/ /_/g');


  ##sanitize file names
  file_name=$( echo "$input_ws" | cut -d'_' -f1,2,3 )
  file_name=$( sanitize_filename1 "$file_name" )
  file_txt=$(  echo $dir_txt/${file_name}_${lang}.txt );
  #file_mp3=$(  echo $dir_mp3/${input_ws}_${lang}.mp3 );
  #    file_html=$(  echo $dir_html/${input_ws}_${lang}.html );
  file_mp3=$(  echo $dir_mp3/${file_name}_${lang}.mp3 );

  #file_wav=/tmp/output.wav
  trace "naming: input_wsp: $input_wsp" true
  trace "naming: file_mp3:  $file_mp3" true
  indicator
  commander sleep 3
  #trace "naming: file_wav:  $file_wav" true
}

step2(){
  local result=''
  if [ "$input_wsp" ];then
    result=$(wget -U "Mozilla/5.0" -qO - "http://translate.google.com/translate_a/t?client=t&text=$input_wsp&sl=en&tl=$lang" ) 
    if [ "$result" ];then
      #echo "$result" >> $TODAY_DIR/translate.json
      cleaner=$(echo "$result" | sed 's/\[\[\[\"//') 
      #trace "$result"
      phonetics=$(echo "$cleaner" | cut -d \" -f 5)
      output=$(echo "$cleaner" | cut -d \" -f 1)
      output_wsp=$(echo "$output"|sed 's/ /+/g');
      output_ws=$(echo "$output"|sed 's/ /_/g');
      echo "$output"
#      commander broadcast "$output" &
     #xcowsay $output &

     notify-send "$output" &
      if [ "$phonetics" ];then
        echo  "$phonetics"
        sleep $delay_phone
      # commander  broadcast "$phonetics" &

 #xcowsay  $phonetics &

 notify-send "$phonetics" &
      fi  
    else
      echo reason_of_death 'no results'
    fi
  fi
}

step3(){
  local cmd
  local chars=$( echo "$input" | wc --chars  )
  local words=$( echo "$input" | wc --words  )
  if [ $chars -lt $MAX_CHARS ] && [ $words -lt $MAX_WORDS ] ;then
    if [ ! -f "$file_mp3" ];then
      wget -U Mozilla -q -O - "$@" translate.google.com/translate_tts?ie=UTF-8\&tl=${lang}\&q=${output_wsp} > $file_mp3 
    else

      trace "use cached file" true
      commander "du -b $file_mp3" 1>&2 
    fi
    if  [ -s "$file_mp3" ];then


      # cmd="play -V1 -q  $file_mp3"
      #      cmd="paplay  $file_mp3"
      #http://www.cyberciti.biz/faq/convert-mp3-files-to-wav-files-in-linux/
      #commander mpg321 -w $file_wav $file_mp3
      #cmd="paplay1 $file_wav"
      cmd="paplay2 $file_mp3"
      #    mpg321 $file_mp3 1> /dev/null
      print color 34 "[PLAYING] $cmd";  
      commander "$cmd" #2>/tmp/err
      commander sleep 2
    else
      print error "[Error] file not found: $file"
    fi
  else
    print error "[skipping] string is away to long"
  fi

}
steps(){

  commander set_env

  #exiting
commander  step0
 commander  step1
commander  step2
  [ "$MODE_SOUND" = true ] &&  step3 || ( print color 36 '[reminder] MODE:MUTE' )
}
#set_args "$@"
#lang="$arg0"
#input1="$opts"
if [ $# -gt 1 ];then
 lang="$1"
shift
   input=$( echo "$@" | sed 's_\\n__g' ) 
  input=$( commander  sanitize_string1 "$input" )
steps  
else
  echo reason_of_death "need 2 arguments - got $#"
fi

