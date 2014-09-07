#source init.cfg
#return
test1(){
file=${1:-use.cfg}
( 

source  $file
use assert

 echo "res: $? "
use assert333

 echo "res: $? "

)
 echo "res: $? "
  echo
} 



test2(){
source use_sh.cfg
use_sh commitment
}
test2
