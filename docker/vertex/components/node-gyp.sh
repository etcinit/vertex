#!/bin/sh

# Installs dependencies for using node-gyp.
apt-get install --no-install-recommends -y -q \
    python2.7 python2.7-minimal g++ gcc libc-dev make
