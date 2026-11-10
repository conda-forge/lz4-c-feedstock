#!/bin/bash
set -ex

# CMake, as on Windows, so that lz4's CMake package (lib/cmake/lz4: LZ4::lz4_shared
# and lz4::lz4) is installed on unix too. Shared only: lz4-c-static ships the
# static library and the config that also lists it.
cmake -S build/cmake -B _build -GNinja ${CMAKE_ARGS} \
  -DCMAKE_BUILD_TYPE=Release \
  -DBUILD_SHARED_LIBS=ON \
  -DBUILD_STATIC_LIBS=OFF \
  -DLZ4_BUILD_CLI=ON \
  -DLZ4_BUILD_LEGACY_LZ4C=ON
cmake --build _build

if [[ "$CONDA_BUILD_CROSS_COMPILATION" != "1" ]]; then
  make -C tests datagen

  # Test
  LZ4=./_build/lz4
  DATAGEN=./tests/datagen

  # This is a shorter version of `make lz4-test-basic`.
  $DATAGEN -g0     | $LZ4 -v     | $LZ4 -t
  $DATAGEN -g16KB  | $LZ4 -9     | $LZ4 -t
  $DATAGEN         | $LZ4        | $LZ4 -t
  $DATAGEN -g6M -P99 | $LZ4 -9BD | $LZ4 -t
  $DATAGEN -g17M   | $LZ4 -9v    | $LZ4 -qt
  $DATAGEN -g33M   | $LZ4 --no-frame-crc | $LZ4 -t
  $DATAGEN -g256MB | $LZ4 -vqB4D | $LZ4 -t
fi

cmake --install _build
