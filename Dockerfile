# Version: 0.0.3 - Asterisk 14.3.0 with pjsip 2.6 and opus,g729 codecs
FROM ubuntu:trusty
MAINTAINER cd "cleardevice@gmail.com"

ENV TERM=xterm
ENV OPUS_VERSION=1.1.4
ENV ASTERISK_VERSION=14.3.0
ENV PJSIP_VERSION=2.6

ADD ./conf /tmp
ADD ./scripts /

RUN /bin/sh /build.sh

WORKDIR /etc/asterisk
CMD ["/bin/sh", "/start.sh"]
