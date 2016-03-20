FROM debian:jessie

MAINTAINER Eduardo Trujillo <ed@chromabits.com>

# Set environment to non-interactive
ENV DEBIAN_FRONTEND noninteractive
USER root

RUN mkdir /tmp/vctl
COPY vctl /tmp/vctl
RUN apt-get update \
  && apt-get install -y --no-install-recommends wget ca-certificates xz-utils make build-essential libgmp-dev \
  && wget https://github.com/commercialhaskell/stack/releases/download/v1.0.4/stack-1.0.4-linux-x86_64.tar.gz -O stack.tar.gz \
  && tar -xvf stack.tar.gz \
  && mv stack-*-linux-x86_64/stack /usr/local/bin \
  && rm -r stack-*-linux-x86_64 \
  && rm stack.tar.gz \
  && mkdir /root/.stack \
  && cd /tmp/vctl \
  && stack setup \
  && stack build --copy-bins \
  && cd \
  && rm -r /tmp/vctl \
  && rm -r ~/.stack \
  && apt-get purge -y wget make build-essential xz-utils \
  && apt-get autoremove -y \
  && apt-clean \
  && cp /root/.local/bin/vctl /usr/local/bin \
  && rm /root/.local/bin/vctl

COPY root /

# Make setup scripts executable
RUN chmod u+x /opt/vertex/*.sh && chmod u+x /opt/vertex/*/**.sh

# Create groups and setup a non-root user
RUN /opt/vertex/build/users.sh \
    && /opt/vertex/build/repos.sh \
    && /opt/vertex/components/base.sh \
    && /opt/vertex/components/nodejs.sh \
    && /opt/vertex/components/hhvm.sh \
    && /opt/vertex/components/composer.sh \
    && /opt/vertex/build/clean.sh

COPY public /var/www/vertex/public
COPY LICENSE /opt/vertex/
COPY README.md /opt/vertex/

# Set permissions
RUN /opt/vertex/build/post.sh \
    && /opt/vertex/utils/report.sh

# Expose ports
EXPOSE 80

VOLUME /var/www/vertex

CMD ["/opt/vertex/run.sh"]
