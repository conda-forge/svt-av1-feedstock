@echo on

cd Build

:REM No GNU style assembler for aarch64 + windows
set "EXTRA_CMAKE_ARGS="
if "%target_platform%" == "win-arm64" set "EXTRA_CMAKE_ARGS=-DCOMPILE_C_ONLY=ON"

cmake %CMAKE_ARGS% -G "NMake Makefiles"                           ^
      -DCMAKE_BUILD_TYPE=Release                     ^
      -DCMAKE_INSTALL_PREFIX:PATH="%LIBRARY_PREFIX%" ^
      -DCMAKE_INSTALL_LIBDIR="lib"                   ^
      -DBUILD_SHARED_LIBS=ON                         ^
      -DNATIVE=OFF                                   ^
      %EXTRA_CMAKE_ARGS%                             ^
      ..

if errorlevel 1 exit 1
nmake

if errorlevel 1 exit 1

nmake install
if errorlevel 1 exit 1
