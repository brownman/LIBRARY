#clear
#pushd `dirname $0` >/dev/null

#exec 2> >( tee /tmp/err >&2)
set -u
set -e
set -x

show_magic(){
  use print; 
  print ok Library Activated!; 
  finder print
  finder translate sh
  use pipe_translate
  pipe_translate dog
}

testing(){
  source /tmp/library.cfg
  test -v LIBRARY_LOADED && show_magic
}

testing 2>/tmp/err  || ( cat /tmp/err )


#popd >/dev/null
