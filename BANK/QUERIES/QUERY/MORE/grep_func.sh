func="$1"
cat /tmp/sourced_cfg | xargs cat | grep "$func" -B 4 -A 5

