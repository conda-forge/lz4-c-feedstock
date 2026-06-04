#!/bin/bash
set -ex

mkdir -p build
cd build

cmake ${CMAKE_ARGS} -DBUILD_SHARED_LIBS=ON -DBUILD_STATIC_LIBS=ON -GNinja ../build/cmake
ninja
ninja install
