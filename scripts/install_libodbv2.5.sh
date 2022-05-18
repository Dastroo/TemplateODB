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

if [ $redhat == 1 ]; then
	dnf install bpkg
fi

bpkg create -d libodb-gcc cc  \
  config.cxx=g++              \
  config.cc.coptions=-O3      \
  config.install.root=/usr    \
  config.install.sudo=sudo
  
cd libodb-gcc

bpkg add https://pkg.cppget.org/1/beta

bpkg fetch

bpkg build libodb

bpkg build libodb-pgsql

bpkg install --all --recursive

if [ $debian == 1 ]; then
	mv /usr/lib/libodb* /usr/lib/x86_64-linux-gnu/
fi

