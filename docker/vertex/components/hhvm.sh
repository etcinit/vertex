#!/bin/sh

echo "[VERTEX] Installing HHVM..."
apt-get install -y -o Dpkg::Options::="--force-confold" nginx-light hhvm libgmp10
apt-get clean
service nginx stop

echo "[VERTEX] Setting up HHVM as the main PHP runtime..."
/usr/share/hhvm/install_fastcgi.sh
/usr/bin/update-alternatives --install /usr/bin/php php /usr/bin/hhvm 60

# Append "daemon off;" to the beginning of the configuration so that Nginx
# does not attempt to daemonize
echo "[VERTEX] Nginx configuration..."
echo "daemon off;" >> /etc/nginx/nginx.conf
