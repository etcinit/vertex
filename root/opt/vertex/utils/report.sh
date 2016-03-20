#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

/opt/vertex/utils/vsay.sh "Version Report"

echo "----- NodeJS:"
node --version

echo "----- NPM:"
npm --version

echo "----- HHVM:"
hhvm --version

echo "----- Composer:"
composer --version
