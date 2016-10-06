# docker-asterisk-latest-pjsip-fail2ban: Docker image
[![](https://images.microbadger.com/badges/image/cleardevice/docker-asterisk-latest-pjsip-fail2ban.svg)](https://microbadger.com/images/cleardevice/docker-asterisk-latest-pjsip-fail2ban "Get your own image badge on microbadger.com") 
[![](https://images.microbadger.com/badges/version/cleardevice/docker-asterisk-latest-pjsip-fail2ban.svg)](https://microbadger.com/images/cleardevice/docker-asterisk-latest-pjsip-fail2ban "Get your own version badge on microbadger.com")


You can find this image on the docker hub at: https://hub.docker.com/r/cleardevice/docker-asterisk-latest-pjsip-fail2ban/

##### Docker image with Certified Asterisk 14 LTS version and Fail2ban on Ubuntu 64bits (14.04.2 LTS)

This is the Docker latest Asterisk 14.0.2 version on Ubuntu X86_64 with SIP and PJSIP version 2.5.5.

Includes:

- Asterisk 14.0.2
- Sip and new pjsip 2.5.5 channel enabled
- opus, g729 codec
- Fail2ban (v0.8.11)

To pull it:

`# docker pull cleardevice/docker-asterisk-latest-pjsip-fail2ban`

For compile it on your own platform/server from the Dockerfile:

`$ git clone https://github.com/cleardevice/docker-asterisk-latest-pjsip-fail2ban`

`$ cd docker-asterisk-latest-pjsip-fail2ban`

`$ docker build -t myrepository/asterisk01 .`

To execute it:

Asterisk PBX needs to use a big range of ports, so it needs to be executed with docker version 1.5.0 or higher (available in docker ubuntu sources) for being able to launch the image specifying a range of ports. For example:

`# docker run --restart=always --privileged --name asterisk01 -d -p 5060:5060 -p 5060:5060/udp -p 10000-10500:10000-10500/udp -v <path to host folder with asterisk confings>:/etc/asterisk cleardevice/docker-asterisk-latest-pjsip-fail2ban`

and connect to asterisk CLI with:

`# docker exec -it asterisk01 asterisk -rvvvvv`

Notice:

> Seems that opening too much ports in a docker images, consumes a lot of resources in your docker host and may fail to launch it. So giving that every SIP call can use up to 4 RTP ports, it is convenient to open only the necessary RTP ports for the expected calls. In this case we open 500 RTP ports for 125 expected concurrent calls. From 10000 to 10500. Don't forget to configure that RTP ports in the /etc/asterisk/rtp.conf file:

```
# rtpstart=10000
# rtpend=10500
```

### Fail2ban ###

To manage Fail2ban, login to asterisk container:

`# docker exec -it asterisk01 bash`

Check Fail2ban status:

`# service fail2ban status`

Check Fail2ban Asterisk rules:

```
# fail2ban-client status asterisk-iptables
# fail2ban-client status asterisk-security-iptables
```

Show fail2ban iptables rules:

`# iptables -nL fail2ban-ASTERISK`

For example you can see:

```
Chain fail2ban-ASTERISK (1 references)
target     prot opt source               destination
REJECT     all  --  1.2.3.4              0.0.0.0/0            reject-with icmp-port-unreachable
RETURN     all  --  0.0.0.0/0            0.0.0.0/0
```

To unblock IP address use:

`# iptables -D fail2ban-ASTERISK -s 1.2.3.4 -j DROP`
