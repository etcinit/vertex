#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

/opt/vertex/utils/vsay.sh "Adding sources..."
apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 \
    0x5a16e7281be7a449
echo deb http://dl.hhvm.com/debian jessie main \
    | tee /etc/apt/sources.list.d/hhvm.list

apt-get update -y

apt-get dist-upgrade -y
