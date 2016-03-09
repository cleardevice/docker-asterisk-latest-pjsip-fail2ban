#!/bin/sh -x

eval $(cat /env)

# install run packages
apt-get install $minimal_apt_get_args $RUN_PACKAGES

# fail2ban configure
rm /etc/fail2ban/filter.d/asterisk.conf
cp /tmp/asterisk*.conf /etc/fail2ban/filter.d/
cat /tmp/jail.conf >> /etc/fail2ban/jail.conf

# clean
apt-get remove --purge -y $BUILD_PACKAGES
apt-get -y autoremove
apt-get -y clean
rm -rf /tmp/* /var/tmp/*
rm -rf /var/lib/apt/lists/*
