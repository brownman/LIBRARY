
#sleep 5

#depend: yad gxmessage
#info: make a commitment - write it down.
#set -e
#set -x
set -o nounset
#set -e
use point
use vars
use assert
use flite1
use pipe_translate
use file_update
use dialog_scale
use dialog_sleep
use dialog_add_line
use print
use exiting
use_sh string_to_buttons
#use trap_err
#$cmd_trap_err
#print error use yad instead
#exiting
set_env(){
#commander ensure touch $file_done
NAME=ofer
touch $file_done
commander assert file_exist "$file_done"
}


intro_motivation(){
cat << FILE
describe your wish - what you want to get  
+ what u do for others!! on suspension 
practicing 
time estimation 
peace of cake
FILE
echo
}

string_to_buttons_1(){
local line="$@"
sleep 5
word=$( commander    $builtin_string_to_buttons $line )
test -n "$word" && ( commander        pipe_translate $word ) 
}

#$cmd_trap_err
#$cmd_trap_exit
#$cmd_trap_err

#set -e
set_sleep(){
local delay="${1:-60}"
local min=$( dialog_scale 'Estimate duration (m)' )
test -n "$min" || { exiting;  }
let "delay = 60 * $min"
echo $delay
}

dialog_sleep_1(){
#local num=$( set_sleep ${1:-})
#assert is_number "$num"
local sec="$1"
shift
local line="$@"
commander time_update
set -u
let "hour2=$hour1 + 1"
commander dialog_sleep $sec \"$hour1:$minute1 - $line\" \"$hour1 - $hour2\"
}

intro_give(){
xcowsay 'give 1 minute' 
xcowsay 'win 9 minutes' 
xcowsay '+ blessing' 
}

intro_take(){
xcowsay 'won a blessing !'
}
flite_1(){
local   str="$@"
flite1 "$str" &
sleep .2
flite1 "$str" &
sleep .2
flite1 "$str" 

}
intro_robot(){
xcowsay 'tell the robot what to do later'
flite_1 "$NAME"
sleep 1
flite_1 'it is easy for a robot' 
}


run(){
set_env
set -u
local line_recent=''
test -s $file_done && { set -o pipefail; line_recent=$(cat $file_done | tail -1 | cut -d' ' -f2- ); }
print color 33 line_recent $line_recent
#exiting 
sleep 1
line=$( dialog_add_line $file_done  "$line_recent" ) 
string_to_buttons_1  $line
}

steps(){
intro_robot
run
dialog_sleep_1 60 'give'
intro_take
run
dialog_sleep_1 480 'take'
intro_give
run
dialog_sleep_1 60 'give'
point_up
point_show
}

delay=${1:-60}
file_done=/tmp/done
steps
