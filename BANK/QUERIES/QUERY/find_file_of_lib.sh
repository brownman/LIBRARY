set -o nounset
str="$1"
grep "$str" /tmp/cfgs
