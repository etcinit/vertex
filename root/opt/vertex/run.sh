#!/bin/bash

vlogo

vsay "Updating permissions for /var/www/..."

# Update permissions so that Nginx can access files
chown -R www-data:users /var/www/
chmod g+w /var/www

echo "Done."

# Start services (HHVM)
vsay "Starting HHVM (Proxygen) server..."

echo "To stop the server press CTRL+C at any time."
echo ""

/usr/bin/hhvm --version
/usr/bin/hhvm -m server \
    -c /opt/vertex/hhvm/server.ini \
    -c /opt/vertex/hhvm/site.ini

