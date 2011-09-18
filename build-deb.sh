#!/bin/bash

if [ -z "$2" ]; then
    echo "usage $0 PackageName VersionNumber"
    exit 1
fi

set -ex

python setup.py clean
python setup.py sdist
python setup.py clean

typeset -l lowername
lowername=$1
mv dist/$1-$2.tar.gz ../${lowername}_$2.orig.tar.gz

rm -rf dist build

fakeroot dpkg-buildpackage -i.git -S -sa
