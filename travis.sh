#!/usr/bin/env bash
set -u

trap_err_travis(){
  echo $FUNCNAME
  echo "CALLER: $(caller)"
}
export -f trap_err_travis
trap trap_err_travis ERR

dir_self=$( cd `dirname $0`; pwd )

install(){
  chmod u+x *.sh $dir_self -R
  $dir_self/install.sh
}

set_env(){
    source /tmp/library.cfg
}

test1(){
  commander cat /tmp/target
  assert file_exist "$dir_self/test.sh"
  commander $dir_self/test.sh
}
step1(){
  local str=$1
  echo "[STEP] $str" 
  eval "$str" 1>/tmp/out 2>/tmp/err || { cat /tmp/err ; exit 1; }
}

steps(){
  step1 install
  step1 set_env
  step1 test1
}


steps
