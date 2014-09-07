
set -o nounset
str=${1:-spellcheck}
dir=${2:-$dir_root}
find "$dir" -iname "$str"
