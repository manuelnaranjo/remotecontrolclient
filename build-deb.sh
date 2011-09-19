#!/bin/bash

if [ -z "$1" ]; then
    echo "usage $0 PackageName"
    exit 1
fi

set -ex

python setup.py clean
python setup.py sdist
python setup.py clean

VERSION=$(python -c 'from RemoteControlClient import __version__; print __version__')

typeset -l lowername
lowername=$1
mv dist/${1}-${VERSION}.tar.gz ../${lowername}_${VERSION}.orig.tar.gz

rm -rf dist build

fakeroot dpkg-buildpackage -i.git -S -sa
