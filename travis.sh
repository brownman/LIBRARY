#!/usr/bin/env bash
set -u

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
  commander $dir_self/test.sh
}

steps(){
  install
  set_env
  test1
}


steps
