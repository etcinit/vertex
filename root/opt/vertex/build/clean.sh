#/bin/bash
set -euo
IFS=$'\n\t'

/opt/vertex/utils/vsay.sh "Running cleanup tasks..."

echo "Removing documentation..."

find /usr/share/doc -depth -type f ! -name copyright|xargs rm || true
find /usr/share/doc -empty|xargs rmdir || true
rm -rf /usr/share/man /usr/share/groff /usr/share/info /usr/share/lintian \
    /usr/share/linda /var/cache/man

apt-get clean

echo "Cleaned apt-get cache."

rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

echo "Cleared temporal directories."
