:: This rougly follow what projects' appveyor file does.


md build
cd build

:: Build both, shared and static library, so that one can link against the preferred on in this setting.s
cmake %CMAKE_ARGS% -DBUILD_SHARED_LIBS=ON -DBUILD_STATIC_LIBS=ON -GNinja ..\build\cmake
if errorlevel 1 exit 1

ninja
if errorlevel 1 exit 1

ninja install
if errorlevel 1 exit 1

:: Test.
if not "%CONDA_BUILD_CROSS_COMPILATION%" == "1" (
  lz4 -i1b lz4.exe
  if errorlevel 1 exit 1
  lz4 -i1b5 lz4.exe
  if errorlevel 1 exit 1
  lz4 -i1b10 lz4.exe
  if errorlevel 1 exit 1
  lz4 -i1b15 lz4.exe
  if errorlevel 1 exit 1
)
