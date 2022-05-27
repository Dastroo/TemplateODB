#!/bin/bash
#https://codesynthesis.com/products/odb/doc/install-build2.xhtml#linux-build2
if [ "$(whoami)" != root ]; then
    echo Please run this script as root or using sudo
    exit
fi

redhat=0
debian=0

if [ -f "/etc/redhat-release" ]; then
    redhat=1
fi

if [ -f "/etc/debian_version" ]; then
    debian=1
fi

if [[ $debian == 0 && $redhat == 0 ]]; then
    echo "script only supports redhat and debian based distros"
    exit
fi

if [ $debian == 1 ]; then
    if [ $# == 0 ]; then
        echo "you need to do: gcc --version and then pass the major version $0 X \n see https://www.codesynthesis.com/products/odb/doc/install-build2.xhtml#linux-odb for more details"
    fi
fi

if [ $redhat == 1 ]; then
    dnf install bpkg
    dnf install gcc-plugin-devel
elif [ $debian == 1 ]; then
    apt install gcc-"$1"-plugin-dev
else
    echo "script only supports redhat and debian based distros"
    exit
fi

cd ~ || exit
mkdir -p odb-build
cd odb-build

bpkg create -d odb-gcc cc \
    config.cxx=g++ \
    config.cc.coptions=-O3 \
    config.bin.rpath=/usr/lib \
    config.install.root=/usr \
    config.install.sudo=sudo

cd odb-gcc || exit

bpkg build odb@https://pkg.cppget.org/1/beta

bpkg test odb

bpkg install odb

which odb

odb --version
