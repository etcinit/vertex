#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# Install composer
/opt/vertex/utils/vsay.sh "Downloading and installing composer..."

curl -O http://getcomposer.org/composer.phar
chmod +x composer.phar
mv composer.phar /usr/local/bin/composer
