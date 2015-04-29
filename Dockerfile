FROM google/debian:wheezy
MAINTAINER Eduardo Trujillo <ed@chromabits.com>

# Set environment to non-interactive
ENV DEBIAN_FRONTEND noninteractive

COPY docker /
COPY public /var/www/vertex/public

# Add source repositories and install essential packages
RUN sh /vertex/repos.sh; \
    apt-get update -y \
    && apt-get install --no-install-recommends -y -q \
    curl python build-essential git ca-certificates; apt-get clean

# Install components, bundles, and then clean up
RUN sh /vertex/components/nodejs.sh; \
    sh /vertex/components/hhvm.sh; \
    sh /vertex/components/zsh.sh; \
    sh /vertex/setup.sh; \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Create groups and setup a non-root user
RUN groupadd vertices; \
    usermod -G vertices root && usermod -G vertices www-data; \
    useradd -ms /bin/zsh vertex && usermod -G vertices vertex

ENV HOME /home/vertex
USER vertex
RUN cp /vertex/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc \
    && cp -R /vertex/.oh-my-zsh /home/vertex/.oh-my-zsh \
    && echo "echo -e \"Welcome to \e[42;97mVERTEX\"" >> \
    /home/vertex/.zshrc

# Switch back to root
USER root

# Set permissions
RUN chmod u+x /vertex/*.sh && ln -s /vertex/login.sh /usr/local/bin/begin; \
    chown -R www-data:vertices /var/www/vertex

# Expose ports
EXPOSE 80

VOLUME /var/www/vertex

CMD ["/vertex/run.sh"]
