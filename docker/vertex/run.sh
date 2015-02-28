#!/bin/bash

# Update permissions so that Nginx can access files
chown -R www-data:vertices /var/www/
chmod g+w /var/www

# Start services (HHVM and Nginx)
echo "[VERTEX] Starting HHVM server..."
touch /var/log/hhvm/error.log
service hhvm start

echo "[VERTEX] Starting Nginx server..."
nginx && tail -f /var/log/hhvm/error.log \
    && tail -f /var/log/nginx/error.log \
    && tail -f /var/log/nginx/access.log
