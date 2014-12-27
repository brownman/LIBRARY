clear
pushd `dirname $0` >/dev/null

exec 2> >( tee /tmp/err >&2)
testing(){
source library.cfg;
use print; print ok Library Activated!; 
finder print
finder translate sh
use pipe_translate
pipe_translate dog
}
(set -e; testing ) || ( cat /tmp/err )


popd >/dev/null
