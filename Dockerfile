FROM debian:stretch-slim

ENV DEBIAN_FRONTEND noninteractive

ARG GRAV_VERSION=1.5.1
ARG GRAV_URL=https://getgrav.org/download/core/grav-admin/${GRAV_VERSION}

ARG APT_FLAGS_COMMON="-qq -y --no-install-recommends"
RUN apt-get update && apt-get install ${APT_FLAGS_COMMON} \
    nginx \
    php-fpm \
    php-mbstring \
    php-gd \
    php-curl \
    php-zip \
    php-xml \
    curl \
    unzip \
    wget \
    neovim \
    ruby-dev \
    libffi-dev \
    rubygems \
    build-essential \
    && gem install sass --no-user-install \
    && apt-get ${APT_FLAGS_COMMON} autoremove \
    && apt-get ${APT_FALGS_COMMON} clean \
    && rm -rf /var/lib/apt/lists/*

RUN wget ${GRAV_URL} -O /tmp/grav.zip && \
    unzip /tmp/grav.zip -d /tmp/ && \
    mkdir -p /srv/www && \
    mv /tmp/grav*/* /srv/www/ && \
    chown -R www-data:www-data /srv/www

#RUN mkdir -p /srv/www/user/themes/thilda/scss/template && \
#    cp /srv/www/user/themes/antimatter/scss/template.scss /srv/www/user/themes/thilda/scss/

RUN rm -rf /etc/nginx/sites-enabled/*

COPY docker-assets/ /
WORKDIR /srv/www

ENTRYPOINT ["/docker-entrypoint.sh"]

