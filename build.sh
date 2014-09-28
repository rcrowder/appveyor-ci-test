#!/bin/bash -e
echo Running build.sh from $PWD

export OS_BUILD=64
export GCC_TYPE=gcc481

#		Win32		Win64
#C compiler	mingw32-gcc	mingw64-gcc
#C++ compiler	mingw32-gcc-c++	mingw64-gcc-c++
#
#C compiler		
#		Win32	i686-w64-mingw32-gcc
#		Win64	x86_64-w64-mingw32-gcc
#C++ compiler		
#		Win32	i686-w64-mingw32-g++
#		Win64	x86_64-w64-mingw32-g++

if [[ "${OS_BUILD}" == "64" ]] ; then
	export MINGHOST=x86_64-w64-mingw32
else
	export MINGHOST=i686-w64-mingw32
fi

export CC=$MINGHOST-gcc
export CXX=$MINGHOST-g++
export LD=$MINGHOST-ld

$CC --version
$CXX --version
$LD --version

echo Current directory contents;
ls -al

echo Starting cmake
cmake \
    -DCMAKE_BUILD_TYPE=Debug \
    -DCMAKE_TOOLCHAIN_FILE=/home/travis/build/rcrowder/travis-ci-test/MinGW-W64-CrossCompile-Windows.cmake \
    ..

echo Running make
make

echo Current directory contents;
ls -al

echo Built an exe
file test2.exe

echo Linting
vera++\bin\vera++ --vc-report --error test.cpp

echo Finished running build.sh
