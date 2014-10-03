clear
pushd `dirname $0` >/dev/null

exec 2> >( tee /tmp/err >&2)
ln -s $PWD/library.cfg /tmp
ls -l /tmp/library.cfg
popd >/dev/null
