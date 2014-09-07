#!/bin/bash
#info: update the desktop wallpaper
#url: http://www.commandlinefu.com/commands/matching/wallpaper/d2FsbHBhcGVy/sort-by-votes
#depend: imagemagic nitrogen

# about file:
#  
#
#
#set -x
#exec 2>/tmp/err
#exec 1>/tmp/out
set -o nounset
#source /tmp/cfgs
#source /tmp/exports
#hotkey_set 5 $0
set -o nounset
update_args(){
    arr1=( override file_txt color size point_size x y )
    str="${arr1[@]}"
    max=${#arr1[@]}
    #echo $max
    echo $str > /tmp/list
    [ $# -ne $max ] && { print error "got $# args";print ok "please supply these Arguments:\n$str";exit 1; }
    #read day month year <<< $(date +'%d %m %y')
    #read file_txt color size point_size
    read ${str} <<< $( echo $@ )
    echo $str
    echo $@
}


#file_txt=$1
#color=red
#size=400x
#point_size=${4:-20}

#. $TIMERTXT_CFG_FILE
loop_txt_files(){
    #   local cmd="$dir_self/txt_to_image.sh"

    #   local    file_list="$dir_workspace/wallpaper.txt"
    while read line;do
        [ -z "$line" ] && { echo breaking; break; }
        str="$( echo $line )"
        echo "[line] $str"
        #        local   cmd1="$cmd $str"
        update_args ${str}

        stepping  txt2image2

        #        eval "$cmd1"
    done < $file_list

}

set_args(){
    echo
    #update_params '' "$file_txt" 850 350 200x 25 1 false
}
update_params(){
    echo 'generate new text on the background'
    echo -e "background:$1 \n file_txt:$2 \n \
        x:$3 y:$4 \n size:$5 \n point_size:$6"
    background=$1 # /tmp/background.png
    file_txt=$2 #  /tmp/next.txt 
    x=$3 #850
    y=$4  #350
    size=$5 #200x
    point_size=$6 #25
    color=$7 #blue
    override=$8
}

#generate text:
txt2image2(){
    cmd="cat \"$file_txt\" |    convert -background none  -fill $color -size $size  -pointsize $point_size caption:@-  \"$file_image\""
    echo "$cmd"
    eval "$cmd"

}
merge_background(){
    #merge background+text to result.png
    #echo "everride? $override"
    #if [ $override = true ];then
  #      composite -geometry "+$x+$y" $file_image $file_background $file_result 
    #else
        composite -geometry "+$x+$y" $file_image $file_result $file_result 
   # fi
}
update(){

    #  cp $file_result $dir_workspace/result.png
    print ok 'update xfce desktop'
    #xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor0/image-path -s ~/Pictures/lubuntu-default-wallpaper-2.png 
    desktop_env=openbox
    if [ $desktop_env = xfce ];then
        xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor0/image-path -s $file_background
        #~/Pictures/result.png
        xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor0/image-path -s /tmp/result.png
    fi
    nitrogen "/tmp/result.png"
    #gnome:
    #gsettings set org.gnome.desktop.background picture-uri file://"$(find ~/Wallpapers -type f | shuf -n1)"

    #xloadimage $result
}
intro(){
    ls -1 $dir_workspace 
    #    local dir_self=`where_am_i $0`

}
paste_image(){
    echo "[steps]"
    #cat  -n $file_txt
    #set_args
    #generate 

    #args: $file_txt $file_image

    #display $file_image
    #step1
    #display $file_result

    #display $file_result
    echo skip update
    echo 
    print_color 33 DONE
    #dialog_optional show_help1 exo-open "http://www.imagemagick.org/Usage/text/#caption"
    #dialog_optional show_help2 exo-open "http://www.commandlinefu.com/commands/matching/imagemagic/aW1hZ2VtYWdpYw==/sort-by-votes"
    #dialog_optional show_help3 exo-open "http://www.imagemagick.org/Usage/"
    #dialog_optional xfce_help https://wiki.archlinux.org/index.php/xfce

}
display(){

    file=$1
    commander  "  feh $file"
}
set_env(){


    #naming
    file_idea="$file_idea"
    file_image=/tmp/text.png
    file_background=$dir_root/background1.png
    file_result=/tmp/result.png
    file_list="$dir_workspace/wallpaper.txt"
 
    #validate
    assert file_exist $file_list
    assert file_exist $file_background

    #init
    cp $file_background $file_result
}
pango1(){
    convert -gravity center pango:@$dir_workspace/pango_test.txt  /tmp/pango_test.png
}
update_wallpaper(){
                        nitrogen --set-scaled "$file_result"
}
steps(){
    stepping reset
    stepping set_env

    stepping "dialog_optional 'gvim $file_idea'"
    stepping "dialog_optional 'gvim $file_list'"

    stepping loop_txt_files
    #update_args
    #stepping intro

    stepping    merge_background
    
#    stepping "nitrogen $file_result"
stepping update_wallpaper

    echo stepping pango1
}
steps

#dialog_optional 'result' "feh $file_result"
#dialog_optional 'pango_test' "feh "/tmp/pango_test.png"
cat1 /tmp/err
