#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# Installs dependencies for using node-gyp.
/opt/vertex/utils/vsay.sh "Removing node-gyp dependencies..."

apt-get purge -y python2.7 python2.7-minimal g++ gcc libc-dev make

