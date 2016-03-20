#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

case "$1" in
    "")
        echo "Usage: vinstall [package]"
        ;;
    *)
        /opt/vertex/build/update.sh
        apt-get install -y --no-install-recommends $1
        /opt/vertex/build/clean.sh
        ;;
esac
