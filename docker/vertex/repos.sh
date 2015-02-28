#!/bin/sh

echo "[VERTEX] Add sources..."
echo deb http://ppa.launchpad.net/chris-lea/node.js/ubuntu utopic main \
    | sudo tee /etc/apt/sources.list.d/nodejs.list \
    && sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C7917B12
echo deb http://ppa.launchpad.net/nginx/stable/ubuntu utopic main \
    | sudo tee /etc/apt/sources.list.d/nginx.list \
    && sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C300EE8C
wget -O - http://dl.hhvm.com/conf/hhvm.gpg.key | sudo apt-key add -
echo deb http://dl.hhvm.com/ubuntu utopic main \
    | sudo tee /etc/apt/sources.list.d/hhvm.list
echo "deb http://us.archive.ubuntu.com/ubuntu/ utopic universe" \
    >> /etc/apt/sources.list

echo "[VERTEX] Updating repos..."
apt-get update
