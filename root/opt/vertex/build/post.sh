#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

/opt/vertex/utils/vsay.sh "Linking tools and setting final permissions"

ln -s /opt/vertex/utils/vmenu.sh /usr/local/bin/vmenu
ln -s /opt/vertex/utils/vsay.sh /usr/local/bin/vsay
ln -s /opt/vertex/utils/vinstall.sh /usr/local/bin/vinstall
ln -s /opt/vertex/utils/vlogo.sh /usr/local/bin/vlogo

echo "Linked utilities."

chown -R www-data:users /var/www/vertex

echo "Reapplied permissions on /var/www/vertex."
