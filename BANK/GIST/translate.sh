#info: translate a string using google scrapping
#depend: wget sox
export MODE_SOUND=true
set -o nounset
#$cmd_trap_err
set -e

sanitize_string(){
  local   str="$@"
  local str_clean=${str//[^a-zA-Z0-9 ]/ }
  echo "$str_clean"

}
sanitize_filename(){
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
  file_name=$( sanitize_filename "$file_name" )
  file_txt=$(  echo $dir_txt/${file_name}_${lang}.txt );
  #file_mp3=$(  echo $dir_mp3/${input_ws}_${lang}.mp3 );
  #    file_html=$(  echo $dir_html/${input_ws}_${lang}.html );
  file_mp3=$(  echo $dir_mp3/${file_name}_${lang}.mp3 );
  echo "naming: input_wsp: $input_wsp";
  echo "naming: file_mp3:  $file_mp3";
}

step2(){
  result=''
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
      broadcast "$output"
      if [ "$phonetics" ];then
        echo  "$phonetics"
        broadcast "$phonetics"
      fi  
    else
      echo reason_of_death 'no results'
    fi
  fi
}

step3(){
  set -e
  local chars=$( echo "$input" | wc --chars  )
  local words=$( echo "$input" | wc --words  )
  if [ $chars -lt $MAX_CHARS ] && [ $words -lt $MAX_WORDS ] ;then
    if [ ! -f "$file_mp3" ];then
      wget -U Mozilla -q -O - "$@" translate.google.com/translate_tts?ie=UTF-8\&tl=${lang}\&q=${output_wsp} > $file_mp3 
    else
      echo "use cached file"
    fi
    if  [ -s "$file_mp3" ];then

      cmd="play -V1 -q  $file_mp3"
      #    mpg321 $file_mp3 1> /dev/null
      echo "[PLAYING] $cmd";  
      eval "$cmd" 2>/tmp/err

      sleep 1
    else
      echo "[Error] file not found: $file"
    fi
  else
    print error "[skipping] string is away to long"
  fi

}
set_env(){
  MAX_WORDS=30
  MAX_CHARS=400
}
steps(){

  set_env
  step0
  step1
  step2
  [ "$MODE_SOUND" = true ] &&  step3
}
if [ $# -gt 1 ];then
  lang="$1"
  shift
  #    input=$( echo "$@" | sed 's_\\n__g' ) 
  input=$( sanitize_string "$@" )
  steps  
else
  echo reason_of_death "need 2 arguments - got $#"
fi

