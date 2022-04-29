#!/bin/bash

N="9"

bpkg create -d libodb-gcc-"${N}" cc  \
  config.cxx=g++                  \
  config.cc.coptions=-O3          \
  config.install.root=/usr  \
  config.install.sudo=sudo
  
cd libodb-gcc-"${N}"

bpkg add https://pkg.cppget.org/1/beta

bpkg fetch

bpkg build libodb

bpkg build libodb-pgsql  ?sys:libpq

bpkg install --all --recursive

mv /usr/lib/libodb* /usr/lib/x86_64-linux-gnu/
