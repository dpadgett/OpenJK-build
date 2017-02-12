# Dockerfile to build OpenJK
FROM ubuntu:14.04
MAINTAINER Dan Padgett <dumbledore3@gmail.com>

RUN apt-get update
RUN apt-get install -y cmake git build-essential libsdl2-dev libjpeg-dev libpng-dev zlib1g-dev

RUN cd && \
  git clone https://github.com/dpadgett/OpenJK.git && \
  mkdir -p OpenJK/build && \
  cd OpenJK/build && \
  cmake -D BuildMPEngine=OFF \
        -D BuildMPRdVanilla=OFF \
        -D BuildMPGame=OFF \
        -D BuildMPCGame=OFF \
        -D BuildMPUI=OFF \
        -D BuildSPEngine=OFF \
        -D BuildSPGame=OFF \
        -D BuildSPRdVanilla=OFF \
        .. && \
  make -j4

WORKDIR /root/OpenJK/build

CMD cp openjkded.x86_64 /out/.
