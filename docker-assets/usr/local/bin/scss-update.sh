#!/usr/bin/env bash

scss --load-path ${SCSS_LOAD_PATH} --update ${THEME_SCSS_PATH}:${THEME_CSS_COMPILED_PATH}
