#!/bin/bash
set -ex

# Both libraries, as on Windows, so that the installed CMake package lists
# LZ4::lz4_static next to LZ4::lz4_shared; only the static library and that
# config are packaged here (the rest belongs to lz4-c).
cmake -S build/cmake -B _build_static -GNinja ${CMAKE_ARGS} \
  -DCMAKE_BUILD_TYPE=Release \
  -DBUILD_SHARED_LIBS=ON \
  -DBUILD_STATIC_LIBS=ON \
  -DLZ4_BUILD_CLI=OFF \
  -DLZ4_POSITION_INDEPENDENT_LIB=ON
cmake --build _build_static
cmake --install _build_static
