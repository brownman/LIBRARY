
#dir="$HOME/.wine/drive_c/Program_Files/Visual_CertExam_Suite"

dir="$HOME/.wine/drive_c/certExam342"
assert dir_exist "$dir"
file=$HOME/Downloads/VCE/LPI.Pass4Sure.117-101.v2013-07-22.by.BMF.267q.vce
assert file_exist "$file"

#117-102.vce

echo "$file"
cmd="wine $dir/manager.exe $file"


( commander $cmd &>/dev/null )
#echo $! >> /tmp/wine.pid
#cat /tmp/wine.pid



