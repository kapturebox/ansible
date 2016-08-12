#!/bin/bash -e

DESTDIR="$(dirname $0)/pkg"
VERSION=${BUILD_NUMBER:-snapshot}

mkdir -p $DESTDIR

fpm -s dir -t deb -n kapture-ansible \
  -v $VERSION \
  -f \
  -a all \
  -p $DESTDIR \
  --exclude "**/*.deb" \
  --exclude '**/.vagrant*' \
  --exclude '**/.git*' \
  --exclude '**/Vagrantfile' \
  --exclude '**/package.sh' \
  ./=/var/kapture/ansible
