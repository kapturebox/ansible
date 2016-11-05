#!/bin/bash -e

DESTDIR="$(dirname $0)/pkg"
VERSION="4.0.${BUILD_NUMBER:-snapshot}"
ITERATION="$(git rev-parse --short HEAD)"

# clean and make dest dir
rm -f $DESTDIR/* && rmdir -p $DESTDIR
mkdir -p $DESTDIR

fpm -s dir -t deb -n kapture-ansible \
  --version $VERSION \
  --iteration $ITERATION \
  --force \
  --architecture all \
  --package $DESTDIR \
  --exclude "**/pkg" \
  --exclude '**/.vagrant*' \
  --exclude '**/.git*' \
  --exclude '**/Vagrantfile' \
  --exclude '**/package.sh' \
  ./=/var/kapture/ansible
