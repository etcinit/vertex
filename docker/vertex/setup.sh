#!/bin/sh

# Install composer
echo "[VERTEX] Installing composer..."
curl -O http://getcomposer.org/composer.phar
chmod +x composer.phar
mv composer.phar /usr/local/bin/composer
