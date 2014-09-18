#!/bin/bash
# http://xmodulo.com/2014/05/take-screenshot-command-line-linux.html
source /tmp/library.cfg
clear
set -o nounset
#set -e

MODE_AUDIO=${1:-false}
seconds=${2:-60}

#source $dir_root/init.cfg

use vars #time / date
use commander #proxy command
use dialog_optional_kill
use indicator
use disown1
use dialog_optional
use dialog_confirm
use dialog_sleep
use cat1
use assert
commander depend byzanz-record


trap_exit(){
xcowsay exiting &
#dialog_optional_cmd 'view recent recording?' 'showing'
}

set_env(){
  resx=1280
  resy=800

  time_update
  time1="${time_ws}_${date_ws}"
  dir=/tmp/screencast
  if [ ! -d "$dir" ];then
    mkdir -p $dir
  fi

  set_cmd_record

}


set_cmd_record(){
  if [ "$MODE_AUDIO" = true ];then
    file_output="$dir/${time1}.ogg"
    cmd_record="byzanz-record --x=0 --y=0 --width=$resx  --height=$resy $file_output --audio --duration=$seconds"
  else
    file_output="$dir/${time1}.gif"
    cmd_record="byzanz-record --duration=$seconds --x=0 --y=0 --width=$resx  --height=$resy $file_output"
  fi
  
}

breaking(){
  xcowsay Breaking
  xcowsay 'show-time'
  showing
  trap - SIGINT
}

showing(){
  if [ "$MODE_AUDIO" = true ];then
    commander vlc "$file_output"
  else
    cmd_browser="$BROWSER $file_output"
    commander $cmd_browser
    wmctrl -a chrome
  fi
}


steps(){
  set_env


  #trap breaking SIGINT

  trap trap_exit EXIT
trap trap_exit SIGTERM
#commander trap breaking SIGINT
( commander "$cmd_record"  )&
local  pid=$!
echo pid: $pid

dialog_sleep $seconds 
( commander kill -2 "$pid" )
  


#commander indicator "$?"

dialog_optional 'view recent recording?' && showing
#kill -2 0
#commander  sleep 3

#commander   kill -s SIGINT $pid
  #dialog_optional_kill $!
  
  #dialog_optional_kill $pid

  #trap - SIGINT
  #breaking
}

while :;do
commander dialog_optional  'record new screencast ?' 'y/n' || break
steps #& # && showing
#echo $! > /tmp/screencast.pid
#cat1 /tmp/screencast.pid true
done

#https://www.youtube.com/watch?v=mNz5Lrc06_s
#https://wiki.archlinux.org/index.php/RecordMyDesktop
#https://aur.archlinux.org/packages/?O=0&C=0&SeB=nd&K=screencast&SB=v&SO=d&PP=50&do_Search=Go
#http://www.upubuntu.com/2012/05/eight-best-screencastingdesktop.html
#http://forum.fedoraonline.it/viewtopic.php?id=20349
#http://manpages.ubuntu.com/manpages/oneiric/en/man1/byzanz-record.1.html#contenttoc4

#audio? choose:      ogg, ogv


#info: screencast maker
#depend: byzanz-record google-chrome
#http://www.unixmen.com/make-animated-gif-screencasts-easily-byzanz/
#http://pkgs.org/download/byzanz
#http://askubuntu.com/questions/107726/how-to-create-animated-gif-images-of-a-screencast
#set -e
