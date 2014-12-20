#!/usr/bin/env bash
file_self=$0
dir_self=$( cd `dirname $file_self`;pwd )

pushd $dir_self >/dev/null

#exec 2> >( tee /tmp/err >&2)
ln -s $PWD/library.cfg /tmp
ls -lt /tmp/library.cfg
popd >/dev/null
