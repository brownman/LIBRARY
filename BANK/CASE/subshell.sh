clear

exec -c
MODE=verbose

use ps4
use trace
use rm1

use print
use assert
use ps1

use commander
use indicator
use cat1

switch1(){
  set -u
  local mode=$1
  shift
  local args=( $@ )
  local cmd="${args[@]}"
trace $cmd 
  case $mode in
    verbose)

      set -x 
      set -e
      commander $cmd
      ;;
    normal)
      set +x
      set +e
      commander $cmd
      ;;
    **)
      echo no handler for $mode
      ;;
  esac
}
rm1 trace
if [ $# -gt 1 ];then
  print_g gay subshell
  ( switch1 $@ )
  indicator $?
else 
  print ok enter a command to run in a subshell
fi

cat1 /tmp/trace
