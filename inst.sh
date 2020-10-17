#!/bin/bash

cd $(dirname $0)

if [ ! -e binaries.tar.xz ]; then
	echo "no binaries.tar.xz"
	exit 1
fi

tar Jxf binaries.tar.xz
# extracted to bin/ directory

if [ ! -d bin ]; then
	echo "Something wrong"
	exit 1
fi

cd bin

dest=$HOME/bin

if [ ! -d $dest ]; then
	mkdir $dest
fi

# check install command
which install > /dev/null 2>&1
if [ $? -eq 0 ]; then
	instcmd="install -p"
else
	instcmd="cp -p"
fi

find -type f | sort | while read f; do
	echo "install $(basename $f)"
	$instcmd $f $dest/
done

# link 1bin
cd $dest
for bin in bashhistcompact gorkscrew fwd fwdset golangbuilder gradlebuilder sshcompile sshfwd sshproxy
do
	ln -sf 1bin $bin
done
