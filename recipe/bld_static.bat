@echo on

cd build

ninja install
if errorlevel 1 exit 1

