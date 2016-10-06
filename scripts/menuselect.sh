#!/bin/sh -x
menuselect/menuselect \
--enable-category MENUSELECT_ADDONS \
--enable-category MENUSELECT_APPS \
--enable-category MENUSELECT_CHANNELS \
--enable-category MENUSELECT_CODECS \
--enable-category MENUSELECT_FORMATS \
--enable-category MENUSELECT_FUNCS \
--enable-category MENUSELECT_RES \
--enable codec_opus \
--enable codec_g729a \
--disable BUILD_NATIVE \
--disable res_digium_phone \
--disable codec_g729a \
menuselect.makeopts
