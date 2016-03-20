#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

/opt/vertex/utils/vsay.sh "Refreshing package DB..."

apt-get update -y
