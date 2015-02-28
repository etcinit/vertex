#!/bin/sh

# Update permissions so that Nginx can access files
chown -R www-data:vertices /var/www/
chmod g+w /var/www

# Start services (HHVM and Nginx)
echo "[VERTEX] Starting HHVM server..."
service hhvm start

echo "[VERTEX] Starting Nginx server..."
nginx &

echo "[VERTEX] Setting up developer environment..."

sudo su vertex

echo "[VERTEX] Goodbye"
