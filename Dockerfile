FROM debian:stretch-slim

ENV DEBIAN_FRONTEND noninteractive

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

ARG GRAV_VERSION=1.5.1
ARG GRAV_URL=https://getgrav.org/download/core/grav-admin/${GRAV_VERSION}

ARG USE_SKELETON=false
ARG SKELETON_NAME=onepage-site
ARG SKELETON_VERSION=2.0.0
ARG GRAV_SKELETON_URL=https://getgrav.org/download/skeletons/${SKELETON_NAME}/${SKELETON_VERSION}

RUN if [ ${USE_SKELETON} = "true" ];then wget ${GRAV_SKELETON_URL} -O /tmp/grav.zip; else wget ${GRAV_URL} -O /tmp/grav.zip; fi

RUN unzip /tmp/grav.zip -d /tmp/ \
    && mkdir -p /srv/www \
    && mv /tmp/grav*/* /srv/www/ \
    && chown -R www-data:www-data /srv/www \
    && rm -rf /tmp/grav*

WORKDIR /srv/www
RUN if [ ${USE_SKELETON} = "true" ];then /srv/www/bin/gpm install admin --all-yes; fi \
    && chown -R www-data:www-data /srv/www

#RUN mkdir -p /srv/www/user/themes/thilda/scss/template && \
#    cp /srv/www/user/themes/antimatter/scss/template.scss /srv/www/user/themes/thilda/scss/

RUN rm -rf /etc/nginx/sites-enabled/*

COPY docker-assets/ /

ENTRYPOINT ["/docker-entrypoint.sh"]

