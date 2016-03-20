#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

/opt/vertex/utils/vsay.sh "Installing Nginx..."
apt-get install -y --no-install-recommends nginx-light
