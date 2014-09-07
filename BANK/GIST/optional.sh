#info:  dialog for confirmation prior to running a command
#depend: zenity
set -e
set -o nounset



text="${1:-text0}"
shift
cmd="${@:-xcowfortune}"

step1(){
echo "[cmd will be] $cmd"
cmd1="zenity \
    --notification \
    --window-icon=info \
    --text '$text' \
    --timeout 10"
echo $cmd1
eval "$cmd1" 2>/tmp/err  && { echo $cmd; disown1 "$cmd" 2>/tmp/err ; } || { echo "[skip] $cmd" ;} 
}
step1

echo end_of_single
