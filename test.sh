pushd `dirname $0` >/dev/null

exec 2> >( tee /tmp/err >&2)
testing(){
 source library.cfg;
use print; print ok; print_g pv Library Activated!; 
}
(set -e; testing ) || ( cat /tmp/err )


popd >/dev/null