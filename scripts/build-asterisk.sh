#!/bin/sh -x

cd /tmp

# libopus
wget -O opus.tar.gz http://downloads.xiph.org/releases/opus/opus-1.1.2.tar.gz

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

# asterisk-opus patch
git clone https://github.com/seanbright/asterisk-opus.git

cd ./asterisk
cp ../asterisk-opus/codecs/* codecs/
cp ../asterisk-opus/formats/* formats/
patch -p1 < ../asterisk-opus/asterisk.patch

./bootstrap.sh

sh contrib/scripts/get_mp3_source.sh

# menuselect
make menuselect && \
menuselect/menuselect \
--disable-category MENUSELECT_ADDONS \
--disable-category MENUSELECT_APPS \
--disable-category MENUSELECT_BRIDGES \
--disable-category MENUSELECT_CDR \
--disable-category MENUSELECT_CEL \
--disable-category MENUSELECT_CHANNELS \
--enable-category MENUSELECT_CODECS \
--enable-category MENUSELECT_FORMATS \
--disable-category MENUSELECT_FUNCS \
--disable-category MENUSELECT_PBX \
--enable-category MENUSELECT_RES \
--disable-category MENUSELECT_TESTS \
--disable-category MENUSELECT_OPTS_app_voicemail \
--disable-category MENUSELECT_UTILS \
--disable-category MENUSELECT_AGIS \
--disable-category MENUSELECT_EMBED \
--disable-category MENUSELECT_CORE_SOUNDS \
--disable-category MENUSELECT_MOH \
--disable-category MENUSELECT_EXTRA_SOUNDS \
--enable app_controlplayback \
--enable app_dial \
--enable app_exec \
--enable app_originate \
--enable app_queue \
--enable app_record \
--enable app_senddtmf \
--enable app_stasis \
--enable app_verbose \
--enable app_waituntil \
--enable chan_sip \
--enable pbx_config \
--enable pbx_realtime \
--enable func_callcompletion \
--enable func_callerid \
--disable BUILD_NATIVE

./configure --with-crypto --with-ssl --with-srtp=/usr/include/srtp/ --libdir=/usr/lib/x86_64-linux-gnu
make && make install && make samples

# add g729
wget http://asterisk.hosting.lv/bin/codec_g729-ast130-gcc4-glibc-x86_64-pentium4.so -O codec_g729.so
mv codec_g729.so /usr/lib/x86_64-linux-gnu/asterisk/modules/

touch /var/log/auth.log /var/log/asterisk/messages /var/log/asterisk/security /var/log/asterisk/cdr-csv
