#!/bin/sh

echo "[VERTEX] Installing Node.js..."
apt-get install -y nodejs

# Install Gulp, Bower, Grunt, and other Node.js tools
echo "[VERTEX] Installing Node.js bundle..."
npm install -g gulp bower grunt-cli supervisor mocha forever babel

