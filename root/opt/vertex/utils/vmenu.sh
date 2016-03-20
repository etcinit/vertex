#!/bin/bash

/opt/vertex/utils/vlogo.sh

PS3='#> '
options=(
    "install-vim" "install-dnstools" "install-nginx" "install-node-gyp" 
    "hhvm-logs" "about" "shell" "exit"
)

select opt in "${options[@]}"
do
    case $opt in
        "install-vim")
            /opt/vertex/utils/vinstall.sh vim
            ;;
        "install-dnstools")
            /opt/vertex/utils/vinstall.sh dnsutils
            ;;
        "install-nginx")
            /opt/vertex/build/update.sh
            /opt/vertex/components/nginx.sh
            /opt/vertex/build/clean.sh
            ;;
        "install-node-gyp")
            /opt/vertex/build/update.sh
            /opt/vertex/components/node-gyp.sh
            /opt/vertex/build/clean.sh
            ;;
        "hhvm-logs")
            tail -f /var/log/hhvm/error.log
            ;;
        "about")
            /opt/vertex/utils/report.sh
            ;;
        "shell")
            /bin/bash
            ;;
        "exit")
            break
            ;;
        *)
            echo "Invalid option. Press enter again for options."
            ;;
    esac
done
