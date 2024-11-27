@echo on
md build-static
cd build-static

cmake %CMAKE_ARGS% -DBUILD_SHARED_LIBS=OFF -GNinja ..\build\cmake
if errorlevel 1 exit 1

ninja
if errorlevel 1 exit 1

ninja install
if errorlevel 1 exit 1

