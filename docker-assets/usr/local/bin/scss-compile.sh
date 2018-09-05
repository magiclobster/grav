#!/usr/bin/env bash

sass --load-path ${SCSS_LOAD_PATH} --watch {THEME_SCSS_PATH}:${THEME_CSS_COMPILED_PATH}
