str="$@"
git diff | grep "$str" -B 4 -A 4

