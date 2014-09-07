#!/bin/bash
#info: delay for X seconds
#depend:  
args=${1:-5}

echo "sleep.sh got: $args"
run(){
    dialog_sleep $args
}
run

