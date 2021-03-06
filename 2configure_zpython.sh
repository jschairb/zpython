#!/bin/bash

ZVM_TOOLCHAIN=${ZVM_PREFIX}
export PATH=${PATH}:${ZVM_TOOLCHAIN}/bin:

#copy config files needed to configure zpython (not host)
cp pyconfig.h.zin pyconfig.h.in
cp Modules/Setup.zdist Modules/Setup

#configure cpython to be built statically, also overrided LINKFORSHARED variable,
#although rest variables has been set to link it statically by nacl-gcc
export PYTHONPATH="$(pwd)/Modules:$(pwd)/Lib:$(pwd)"
#export LINKFORSHARED=\
#"-s -static -T ${ZVM_SDK_ROOT}/x86_64-nacl/lib64/ldscripts/elf64_nacl.x.static \
#-melf64_nacl -m64 ${ZRT_ROOT}/lib/zrt.o -L${ZRT_ROOT}/lib -lzrt -lfs -lstdc++"
export CC="x86_64-nacl-gcc"
export CXX="x86_64-nacl-g++"
export AR="x86_64-nacl-ar"
export RANLIB="x86_64-nacl-ranlib"
#export LD_LIBRARY_PATH=${ZVM_TOOLCHAIN}"/lib"
#export CFLAGS="-I${ZRT_ROOT}/lib"
export LINKFORSHARED=" "
export HOSTPYTHON=./hostpython
export HOSTPGEN=./Parser/hostpgen
export LDFLAGS="-s -m64 -Wl,--no-export-dynamic -static-libgcc"
export LIBC=""

./configure \
--host=x86_64-nacl \
--build=x86_64-linux-gnu \
--prefix=/python \
--without-threads \
--enable-shared=no \
--disable-shared 
#--with-suffix=.nexe \
#--with-libs='${LINKFORSHARED} ${LDFLAGS} ${LIBS}'
