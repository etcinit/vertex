#!/bin/bash

# Update permissions so that Nginx can access files
chown -R www-data:vertices /var/www/
chmod g+w /var/www

# Start services (HHVM)
echo "[VERTEX] Starting HHVM server..."
/usr/bin/hhvm -m server -c /vertex/hhvm/server.ini -c /vertex/hhvm/site.ini

