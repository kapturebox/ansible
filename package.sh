#!/bin/bash -e

DESTDIR=$(dirname $0)/pkg
VERSION=${BUILD_NUMBER:-snapshot}

fpm -s dir -t deb -n kapture-ansible \
  -v $VERSION \
  -f \
  -a all \
  -f \
  -p $DESTDIR \
  --exclude '**/.vagrant*' \
  --exclude '**/.git*' \
  --exclude '**/Vagrantfile' \
  ./=/var/kapture/ansible
