FROM ubuntu:14.04
MAINTAINER Eduardo Trujillo <ed@chromabits.com>

# Set environment to non-interactive
ENV DEBIAN_FRONTEND noninteractive

# Install apt-add-repository tool
RUN apt-get update && apt-get install -y wget curl python

# Add source repositories
RUN echo deb http://ppa.launchpad.net/chris-lea/node.js/ubuntu trusty main | sudo tee /etc/apt/sources.list.d/nodejs.list \
    && sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C7917B12
RUN echo deb http://ppa.launchpad.net/nginx/stable/ubuntu trusty main | sudo tee /etc/apt/sources.list.d/nginx.list \
    && sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C300EE8C

RUN wget -O - http://dl.hhvm.com/conf/hhvm.gpg.key | sudo apt-key add -
RUN echo deb http://dl.hhvm.com/ubuntu trusty main | sudo tee /etc/apt/sources.list.d/hhvm.list
RUN echo "deb http://us.archive.ubuntu.com/ubuntu/ precise universe" >> /etc/apt/sources.list

# Update Ubuntu image (this time with extra repos)
RUN apt-get update

## Install Tools, Node.js, PHP, HHVM
RUN apt-get install -y \
    vim git build-essential make nodejs \
    nginx \
    hhvm libgmp10 \
    && service nginx stop

# Install Gulp, Bower, Grunt, and some other tools
RUN npm install -g gulp bower grunt-cli supervisor forever

# Install HHVM
RUN /usr/share/hhvm/install_fastcgi.sh

# Make HHVM the default interpreter
RUN /usr/bin/update-alternatives --install /usr/bin/php php /usr/bin/hhvm 60

# Install Composer, PHPUnit, and Laravel installer
RUN bash -c "wget http://getcomposer.org/composer.phar && chmod +x composer.phar && mv composer.phar /usr/local/bin/composer" \
    bash -c "wget https://phar.phpunit.de/phpunit.phar && chmod +x phpunit.phar && mv phpunit.phar /usr/local/bin/phpunit"

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Add config files
COPY docker /

# Set permission for startup script
RUN chmod u+x /scripts/start.sh

# Set permissions so that HHVM can execute the default project
RUN chown -R www-data:www-data /var/www/vertex/public

# Append "daemon off;" to the beginning of the configuration
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# Expose ports
EXPOSE 80

VOLUME /var/www/vertex

CMD ["/scripts/start.sh"]
