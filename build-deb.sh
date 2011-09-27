#!/bin/bash

if [ -z "$1" ]; then
    echo "usage $0 PackageName"
    exit 1
fi

set -ex

typeset -l lowername
lowername=$1
VERSION=$(python -c "from ${1} import __version__; print __version__")

if [ ! -f ../${lowername}_${VERSION}.orig.tar.gz ]; then
    python setup.py clean
    python setup.py sdist
    python setup.py clean
    mv dist/${1}-${VERSION}.tar.gz ../${lowername}_${VERSION}.orig.tar.gz
    rm -rf dist build
fi

fakeroot dpkg-buildpackage -i.git -S -sa
