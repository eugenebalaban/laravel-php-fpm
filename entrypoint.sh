#!/usr/bin/env bash

###
# A CMD or ENTRYPOINT script for a Dockerfile to use to start a php-fpm
##

if [ ! "on" == "$XDEBUG_MODE" ]; then
    # Disable xdebug
    ln -sf /usr/local/etc/php/docker-php-ext-xdebug-disabled.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
else
    # Enable xdebug
    ln -sf /usr/local/etc/php/docker-php-ext-xdebug-enabled.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
fi

php-fpm