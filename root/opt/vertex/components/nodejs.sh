#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

/opt/vertex/utils/vsay.sh "Installing Node.js..."

mkdir -p /opt/nodejs \
    && curl https://nodejs.org/dist/v5.9.0/node-v5.9.0-linux-x64.tar.gz \
    | tar xzf - -C /opt/nodejs --strip-components=1

ln -s /opt/nodejs/bin/node /usr/local/bin
ln -s /opt/nodejs/bin/npm /usr/local/bin
