# Dockerfile to build OpenJK
FROM ubuntu:14.04
MAINTAINER Dan Padgett <dumbledore3@gmail.com>

RUN dpkg --add-architecture i386 && \
  apt-get update && \
  apt-get install -y cmake git gcc:i386 g++:i386 libsdl2-dev:i386 libjpeg-dev:i386 libpng-dev:i386 zlib1g-dev:i386

WORKDIR /root

RUN git clone https://github.com/dpadgett/OpenJK.git && \
  mkdir -p OpenJK/build

WORKDIR /root/OpenJK/build

CMD \
  sed -i 's/"^i.86$"/"^i.86$|^x86.64$"/' ../CMakeLists.txt && \
  cmake -D BuildMPEngine=OFF \
        -D BuildMPRdVanilla=OFF \
        -D BuildMPGame=OFF \
        -D BuildMPCGame=OFF \
        -D BuildMPUI=OFF \
        -D BuildSPEngine=OFF \
        -D BuildSPGame=OFF \
        -D BuildSPRdVanilla=OFF \
        -D CMAKE_C_FLAGS="-m32 -msse2" \
        -D CMAKE_CXX_FLAGS="-m32 -msse2" \
        .. && \
  make -j4 VERBOSE=1 && \
  cp /root/OpenJK/build/openjkded.i386 /out/.
