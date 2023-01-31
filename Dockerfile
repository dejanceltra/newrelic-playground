FROM ubuntu:jammy

# Needed for apt-get build-dep call later in script
RUN sed -Ei '/.*partner/! s/^# (deb-src .*)/\1/g' /etc/apt/sources.list

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y apt-transport-https build-essential software-properties-common

# PHP repository.
RUN add-apt-repository ppa:ondrej/php

# PHP dependencies
RUN apt-get update
RUN apt-get install -y libmysqlclient-dev php8.1-dev libmcrypt-dev php8.1 libphp8.1-embed apache2 libapache2-mod-php8.1 php8.1-curl

# Other tools
RUN apt-get install -y curl gdb valgrind libpcre3-dev libcurl4-openssl-dev pkg-config postgresql libpq-dev libedit-dev libreadline-dev git golang sudo  gcc-10 nano

RUN useradd -m --shell /bin/bash --uid 1000 dev && \
    mkdir -p /app && \
    chown -R dev:dev /app && \
    adduser dev sudo > /dev/null && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER dev

RUN git config --global --add safe.directory '*'
