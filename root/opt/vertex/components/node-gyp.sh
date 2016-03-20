#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# Installs dependencies for using node-gyp.
/opt/vertex/utils/vsay.sh "Installing node-gyp dependencies..."

apt-get install --no-install-recommends -y -q \
    python2.7 python2.7-minimal g++ gcc libc-dev make

/usr/bin/update-alternatives --install /usr/bin/python python \
    /usr/bin/python2.7 6
