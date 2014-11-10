#!/bin/bash

# Update permissions so that Nginx can access files
chown www-data:root /var/www/ -R

# Start services (HHVM and Nginx)
echo "Starting HHVM server..."
service hhvm start

echo "Starting Nginx server..."
nginx