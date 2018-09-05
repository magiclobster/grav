#!/usr/bin/env bash

scss --load-path ${SCSS_LOAD_PATH} --watch ${THEME_SCSS_PATH}:${THEME_CSS_COMPILED_PATH}


      SCSS_LOAD_PATH: /srv/www/user/themes/antimatter/scss
      THEME_SCSS_PATH:  /srv/www/user/themes/my-theme/scss
      THEME_CSS_COMPILED_PATH: /srv/www/user/themes/tmy-theme/css-compiled/template.css