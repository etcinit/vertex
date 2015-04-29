FROM google/debian:wheezy
MAINTAINER Eduardo Trujillo <ed@chromabits.com>

# Set environment to non-interactive
ENV DEBIAN_FRONTEND noninteractive

COPY docker /
COPY public /var/www/vertex/public

# Add source repositories
RUN sh /vertex/repos.sh

# Install apt-add-repository tool
RUN apt-get update -y \
    && apt-get install --no-install-recommends -y -q \
    curl python build-essential git ca-certificates

# Install HHVM and set it as the default interpreter
RUN sh /vertex/components/nodejs.sh
RUN sh /vertex/components/hhvm.sh
RUN sh /vertex/components/zsh.sh

# Setup bundle
RUN sh /vertex/setup.sh

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Create groups
RUN groupadd vertices
RUN usermod -G vertices root && usermod -G vertices www-data

# Setup a non-root user
RUN useradd -ms /bin/zsh vertex && usermod -G vertices vertex
ENV HOME /home/vertex
USER vertex
RUN cp /vertex/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc \
    && cp -R /vertex/.oh-my-zsh /home/vertex/.oh-my-zsh \
    && echo "echo -e \"Welcome to \e[42;97mVERTEX\"" >> \
    /home/vertex/.zshrc

# Switch back to root
USER root

# Set permissions
RUN chmod u+x /vertex/*.sh && ln -s /vertex/login.sh /usr/local/bin/begin
RUN chown -R www-data:vertices /var/www/vertex

# Append "daemon off;" to the beginning of the configuration so that Nginx
# does not attempt to daemonize
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# Expose ports
EXPOSE 80

VOLUME /var/www/vertex

CMD ["/vertex/run.sh"]
