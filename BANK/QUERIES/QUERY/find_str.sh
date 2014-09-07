set -o nounset
str=${1:-spellcheck}
dir=${2:-.}
grep -lr  "$str" "$dir"
