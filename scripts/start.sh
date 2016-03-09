#!/bin/sh -x
rm /var/run/fail2ban/fail2ban.sock || true
service fail2ban restart
/usr/sbin/asterisk -vvvvvvv
