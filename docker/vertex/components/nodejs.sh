#!/bin/sh

echo "[VERTEX] Installing Node.js..."
mkdir /nodejs && curl http://nodejs.org/dist/v0.12.2/node-v0.12.2-linux-x64.tar.gz | tar xvzf - -C /nodejs --strip-components=1
ln -s /nodejs/bin/node /usr/local/bin
ln -s /nodejs/bin/npm /usr/local/bin
