#!/bin/sh

# Install Gulp, Bower, Grunt, and other Node.js tools
echo "[VERTEX] Installing Node.js bundle..."
npm install -g gulp bower grunt-cli supervisor forever

# Install composer
echo "[VERTEX] Installing composer..."
wget http://getcomposer.org/composer.phar
chmod +x composer.phar
mv composer.phar /usr/local/bin/composer

# Install phpunit
echo "[VERTEX] Installing phpunit..."
wget https://phar.phpunit.de/phpunit.phar
chmod +x phpunit.phar
mv phpunit.phar /usr/local/bin/