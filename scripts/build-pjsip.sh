#!/bin/sh -x

cd /tmp
wget -O pjproject.tar.bz2 http://www.pjsip.org/release/${PJSIP_VERSION}/pjproject-${PJSIP_VERSION}.tar.bz2

mkdir pjproject
tar xjvf pjproject.tar.bz2 -C ./pjproject --strip-components=1

cd pjproject

./configure --libdir=/usr/lib/x86_64-linux-gnu --prefix=/usr --enable-shared

make dep && make && make install && ldconfig && ldconfig -p | grep pj

