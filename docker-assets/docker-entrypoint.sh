#!/usr/bin/env bash

GRAV_SITE_TITLE=${GRAV_SITE_TITLE:-"no title"}
GRAV_SITE_AUTHOR_NAME=${GRAV_SITE_AUTHOR_NAME:-"no author"}
GRAV_SITE_AUTHOR_MAIL=${GRAV_SITE_AUTHOR_MAIL:-"nomail@magiclobster.de"}
GRAV_SITE_DESCRIPTION=${GRAV_SITE_DESCRIPTION:-"no description"}

UPDATE_SCSS=${UPDATE_SCSS:-"false"}

if [[ ${UPDATE_SCSS} = "true" ]]; then
    echo "updating scss"
    scss-update.sh
fi

sed -i "s|title:.*|title: '${GRAV_SITE_TITLE}'|" /srv/www/user/config/site.yaml
sed -i "s|name:.*|name: '${GRAV_SITE_AUTHOR_NAME}'|" /srv/www/user/config/site.yaml
sed -i "s|email:.*|email: '${GRAV_SITE_AUTHOR_MAIL}'|" /srv/www/user/config/site.yaml
sed -i "s|description:.*|description: '${GRAV_SITE_DESCRIPTION}'|" /srv/www/user/config/site.yaml

chown -R www-data:www-data /srv/www/

service php7.0-fpm start
exec nginx -g 'daemon off;'
