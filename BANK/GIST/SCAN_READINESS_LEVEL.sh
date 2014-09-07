#info: parse the readiness level of each script - soon to be a gist
#depend: X 
#source /tmp/cfgs
source /tmp/library.cfg
use assert 
use read_tag
files=`ls -1 .
for file in $files;do
    filename=`basename $file | sed 's/.sh//g'`
    echo "[ $filename ]"
    assert file_exist $file
    ( read_tag $file info )
    ( read_tag $file depend )
    #read_tag $file desc
    #read_tag $file depend
done
