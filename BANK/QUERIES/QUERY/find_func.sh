find_func(){
    set -o nounset
local str="$1"
local dir="${2:-.}"
grep2 -lr "$str\(\){" "$dir"
}
find_func "$1" "$2"
