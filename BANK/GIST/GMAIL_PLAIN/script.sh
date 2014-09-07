#!/bin/bash 
#set -x
#set -e
#date:      16.5.2014
#time:      15:29
#version_id:7
#author:    ofer shaham
#plugin:    gmail-group
#mission:   sending email using a simple gui, use an external text file for updating your mail contacts
#depend:    gxmessage libnotify-bin yad
#check:     ps -ef | grep gmail-notify | grep -v grep
#readme:    figlet GMail-Group-Ver-7
#optional:  gmail-notify curl vim-gtk pv cowsay toilet figlet sox libsox-fmt-mp3 zenity fortunes
#files:     gmail_group_10_lines{.cfg .sh .md .contacts}
set_env(){
set -o nounset
source config.cfg
}
unread(){
    curl -u $user:$password --silent "https://mail.google.com/mail/feed/atom" | tr -d '\n' | awk -F '<entry>' '{for (i=2; i<=NF; i++) {print $i}}' | sed -n "s/<title>\(.*\)<\/title.*name>\(.*\)<\/name>.*/\ \1/p";
    [ $? -eq 0 ] && { notify-send "OK" "retrieving" ; } || {  notify-send "Error" "retrieving" ; exit 1; }  
}
compose(){  
    
    local msg=$( gxmessage -entrytext "$str_first" -sticky -ontop -timeout 3000  -file $file_unread -title "Compose:" )
    if [ -n "$msg" ];then
        echo -e "Subject:${nickname}: $msg" > $file_compose
        cmd="curl -u $user:$password --ssl-reqd --mail-from $from --mail-rcpt $to --url smtps://smtp.gmail.com:465 -T $file_compose"
        eval "$cmd" 
        [ $? -eq 0 ] && { notify-send "OK" "sending"; } || { notify-send "Error" "sending"; exit 1; }
    else
        echo 'skip sending'
    fi
}
steps(){
    set_env
     unread 1>$file_unread
     compose
}
str_first=${1:-''}
steps
