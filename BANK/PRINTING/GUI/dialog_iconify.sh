#!/usr/bin/env bash

# create a FIFO file, used to manage the I/O redirection from shell
PIPE=$(mktemp -u --tmpdir ${0##*/}.XXXXXXXX)
mkfifo $PIPE

# attach a file descriptor to the file
exec 3<> $PIPE

# add handler to manage process shutdown
function on_exit() {
    echo "quit" >&3
    rm -f $PIPE
}
trap on_exit EXIT

# add handler for tray icon left click
function on_click() {
    echo "clicked"
}
export -f on_click

# create the notification icon
run(){
yad --notification                  \
    --listen                        \
    --image="gtk-help"              \
    --text="Notification tooltip"   \
    --command="bash -c on_click" <&3
}
