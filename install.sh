#!/usr/bin/env bash

echo 1>&2 '[INSTALLING] library'
file_self=$0
dir_self=$( cd `dirname $file_self`;pwd )

#pushd $dir_self >/dev/null

#exec 2> >( tee /tmp/err >&2)
ln -s $dir_self/library.cfg /tmp
ln -s $dir_self /tmp/dir_library
ls -lt /tmp/library.cfg
#popd >/dev/null
