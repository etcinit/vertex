#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

/opt/vertex/utils/vsay.sh "Installing HHVM..."
apt-get install --no-install-recommends -y \
    -o Dpkg::Options::="--force-confold" hhvm libgmp10

echo "Setting up HHVM as the main PHP runtime..."

/usr/bin/update-alternatives --install /usr/bin/php php /usr/bin/hhvm 60

echo "Done."

