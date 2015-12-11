#!/bin/sh

echo "[VERTEX] Installing HHVM..."
apt-get install -y -o Dpkg::Options::="--force-confold" hhvm libgmp10
apt-get clean

echo "[VERTEX] Setting up HHVM as the main PHP runtime..."
/usr/bin/update-alternatives --install /usr/bin/php php /usr/bin/hhvm 60

