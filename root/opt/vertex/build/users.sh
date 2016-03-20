#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

/opt/vertex/utils/vsay.sh "Setting up groups and users..."

useradd -ms /bin/bash vertex
usermod -G users root
usermod -G users www-data
usermod -G users vertex

