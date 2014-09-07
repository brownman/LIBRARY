set1(){
print warning "[SET] not allowd"
echo `caller`
}
trap1(){
print warning "[SET] not allowd"
echo `caller`
}



trap_err(){
local str_caller="`caller`"
print func
print error "$str_caller"
}
set_env(){
set +e
cmd_trap_err='trap trap_err ERR'
export -f trap_err
}

steps(){
set_env
#start trapping
$cmd_trap_err
#lock env change on subshells
#trap | grep ERR

shopt -s expand_aliases
alias set=set1
alias trap=trap1

#keep the environment : runner: sourcing > bash -c
source "$file"
}

file=$1
assert file_exist $file

( steps )
