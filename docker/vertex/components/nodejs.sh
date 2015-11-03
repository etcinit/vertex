#!/bin/sh

echo "[VERTEX] Installing Node.js..."
mkdir /nodejs && curl https://nodejs.org/dist/v5.0.0/node-v5.0.0-linux-x64.tar.gz | tar xvzf - -C /nodejs --strip-components=1
ln -s /nodejs/bin/node /usr/local/bin
ln -s /nodejs/bin/npm /usr/local/bin
