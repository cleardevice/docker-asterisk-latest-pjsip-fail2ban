#!/bin/sh -x

cd /tmp

wget -O asterisk.tar.gz http://downloads.asterisk.org/pub/telephony/asterisk/releases/asterisk-${ASTERISK_VERSION}.tar.gz

mkdir asterisk
tar -xzvf asterisk.tar.gz -C ./asterisk --strip-components=1

cd ./asterisk
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
--disable-category MENUSELECT_RES \
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
--enable res_agi \
--enable res_ari \
--enable res_ari_channels \
--enable res_ari_events \
--enable res_ari_playbacks \
--enable res_ari_recordings \
--enable res_ari_sounds \
--enable res_ari_device_states \
--enable res_realtime \
--enable res_rtp_asterisk \
--enable res_rtp_multicast \
--enable res_stasis \
--enable res_stasis_answer \
--enable res_stasis_device_state \
--enable res_stasis_playback \
--enable res_stasis_recording \
--enable res_stun_monitor \
--enable res_timing_timerfd \
--enable func_callcompletion \
--enable func_callerid \
--disable BUILD_NATIVE

./configure --libdir=/usr/lib/x86_64-linux-gnu
make && make install && make samples

touch /var/log/auth.log /var/log/asterisk/messages /var/log/asterisk/security /var/log/asterisk/cdr-csv
