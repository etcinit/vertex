#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

/opt/vertex/utils/vsay.sh "Installing base..."
apt-get install --no-install-recommends -y -q git curl ca-certificates
