install(){
  ./install.sh
}

set_env(){
    source /tmp/library.cfg
}

test1(){
  cat /tmp/target
  ./test.sh
}

steps(){
  install
  set_env
  test1
}


steps
