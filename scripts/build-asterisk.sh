#!/bin/sh -x

cd /tmp

# libopus
wget -O opus.tar.gz http://downloads.xiph.org/releases/opus/opus-${OPUS_VERSION}.tar.gz

mkdir opus
tar -xzvf opus.tar.gz -C ./opus --strip-components=1

cd opus
./configure
make all && make install

# asterisk
cd /tmp
wget -O asterisk.tar.gz http://downloads.asterisk.org/pub/telephony/asterisk/releases/asterisk-${ASTERISK_VERSION}.tar.gz

mkdir asterisk
tar -xzvf asterisk.tar.gz -C ./asterisk --strip-components=1

cd ./asterisk
./bootstrap.sh

sh contrib/scripts/get_mp3_source.sh
sh contrib/scripts/install_prereq install

./configure --with-crypto --with-ssl --with-srtp=/usr/include/srtp/ --libdir=/usr/lib/x86_64-linux-gnu

# menuselect
make menuselect.makeopts
/bin/sh /menuselect.sh

make && make install && make samples

# add g729
wget http://asterisk.hosting.lv/bin/codec_g729-ast140-gcc4-glibc-x86_64-pentium4.so -O codec_g729.so
mv codec_g729.so /usr/lib/x86_64-linux-gnu/asterisk/modules/

# logs
touch /var/log/auth.log /var/log/asterisk/messages /var/log/asterisk/security /var/log/asterisk/cdr-csv
