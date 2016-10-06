# Version: 0.0.2 - Asterisk 14.0.2 with pjsip 2.5.5 + opus,g729 codecs
FROM ubuntu:trusty
MAINTAINER cd "cleardevice@gmail.com"

ENV TERM=xterm
ENV OPUS_VERSION=1.1.3
ENV ASTERISK_VERSION=14.0.2
ENV PJSIP_VERSION=2.5.5

ADD ./conf /tmp
ADD ./scripts /

RUN /bin/sh /build.sh

WORKDIR /etc/asterisk
CMD ["/bin/sh", "/start.sh"]
