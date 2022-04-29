#!/bin/bash
#https://codesynthesis.com/products/odb/doc/install-build2.xhtml#linux-build2

N="9"

sudo apt-get install gcc-"${N}"-plugin-dev

cd ~ || exit
mkdir odb-build
cd odb-build || exit

bpkg create -d odb-gcc-"${N}" cc     \
  config.cxx=g++                  \
  config.cc.coptions=-O3          \
  config.bin.rpath=/usr/lib \
  config.install.root=/usr  \
  config.install.sudo=sudo

cd odb-gcc-"${N}" || exit

bpkg build odb@https://pkg.cppget.org/1/beta

bpkg test odb

bpkg install odb

which odb

odb --version

sudo mv /usr/local/bin/odb* /usr/bin/
