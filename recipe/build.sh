#!/bin/bash
set -ex

export CFLAGS="${CFLAGS} -O3 -fPIC"

mkdir -p build
cd build

cmake ${CMAKE_ARGS} -DBUILD_SHARED_LIBS=ON -DBUILD_STATIC_LIBS=OFF -GNinja ../build/cmake
ninja

if [[ "$CONDA_BUILD_CROSS_COMPILATION" != "1" ]]; then
  ctest --output-on-failure
fi

ninja install
rm -f ${PREFIX}/lib/liblz4.a
