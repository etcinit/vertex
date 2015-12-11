FROM debian:wheezy

MAINTAINER Eduardo Trujillo <ed@chromabits.com>

# Set environment to non-interactive
ENV DEBIAN_FRONTEND noninteractive


# Create groups and setup a non-root user
RUN groupadd vertices; \
    usermod -G vertices root && usermod -G vertices www-data; \
    useradd -ms /bin/bash vertex && usermod -G vertices vertex

ENV HOME /home/vertex
USER vertex
RUN echo "echo -e \"Welcome to \e[42;97mVERTEX\"" >> \
    /home/vertex/.bash_profile

# Switch back to root
USER root

# Add source repositories and install essential packages
RUN sh /vertex/repos.sh; \
    apt-get update -y \
    && apt-get install --no-install-recommends -y -q \
    curl python2.7 python2.7-minimal g++ gcc libc-dev make git sudo \
    ca-certificates; \
    sh /vertex/components/nodejs.sh; \
    sh /vertex/components/hhvm.sh; \
    sh /vertex/setup.sh; \
    sh /vertex/clean.sh

COPY docker /
COPY public /var/www/vertex/public

# Set permissions
RUN chmod u+x /vertex/*.sh && ln -s /vertex/login.sh /usr/local/bin/begin; \
    chown -R www-data:vertices /var/www/vertex

# Expose ports
EXPOSE 80

VOLUME /var/www/vertex

CMD ["/vertex/run.sh"]
