#!/bin/bash
set -ex

export CFLAGS="${CFLAGS} -O3 -fPIC"
make -j${CPU_COUNT} PREFIX=${PREFIX}
cp lib/liblz4.a ${PREFIX}/lib
