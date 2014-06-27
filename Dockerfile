FROM ubuntu
MAINTAINER Eduardo Trujillo

# Set environment to non-interactive
ENV DEBIAN_FRONTEND noninteractive

# Update the Ubuntu image
RUN apt-get update
RUN apt-get install -y software-properties-common python-software-properties
RUN add-apt-repository ppa:chris-lea/node.js
RUN echo "deb http://us.archive.ubuntu.com/ubuntu/ precise universe" >> /etc/apt/sources.list
RUN apt-get update

# Install Node and Git
RUN apt-get install -y nodejs git

# Install Bower and Grunt
RUN npm install -g bower
RUN npm install -g grunt-cli
