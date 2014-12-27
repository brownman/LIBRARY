install(){
  ./install.sh
}

set_env(){
    source /tmp/library.cfg
}

test1(){
  cat /tmp/target
  gxmessage_confirm a b c
}

steps(){
  install
  set_env
  test1
}


steps
