#!/bin/sh

echo "[VERTEX] Installing HHVM..."
apt-get install -y -o Dpkg::Options::="--force-confold" nginx hhvm libgmp10
service nginx stop

echo "[VERTEX] Setting up HHVM as the main PHP runtime..."
/usr/share/hhvm/install_fastcgi.sh
/usr/bin/update-alternatives --install /usr/bin/php php /usr/bin/hhvm 60
