#!/usr/bin/env bash

pushd `dirname $0` >/dev/null

#exec 2> >( tee /tmp/err >&2)
ln -s $PWD/library.cfg /tmp
ls -lt /tmp/library.cfg
popd >/dev/null
