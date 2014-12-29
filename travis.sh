#!/usr/bin/env bash
set -u
set -e

dir_self=$( cd `dirname $0`; pwd )

install(){
  $dir_self/install.sh
}

set_env(){
    source /tmp/library.cfg
}

test1(){
  cat /tmp/target
  $dir_self/test.sh
}

steps(){
  install
  set_env
  test1
}


steps
