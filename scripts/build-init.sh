#!/bin/sh -x

eval $(cat /env)

apt-get update -y
apt-get install $minimal_apt_get_args $SERVICE_PACKAGES $LIBS_PACKAGES $BUILD_PACKAGES
