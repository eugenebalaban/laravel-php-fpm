FROM php:8.0-fpm-alpine

ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
ADD entrypoint.sh /entrypoint.sh

RUN set -xe \
	&& apk add --no-cache pcre-dev ${PHPIZE_DEPS} \
		libmcrypt-dev \
		libxml2-dev \
		libintl \
		gettext-dev \
		openldap-dev \
		freetype-dev \
		libjpeg-turbo-dev	 \
		libpng-dev \
		icu-dev \
		git \
		bash \
		openssh \

	&& chmod uga+x /usr/local/bin/install-php-extensions \
	&& sync \
    && install-php-extensions @composer bcmath memcached apcu \
        calendar fileinfo iconv json mbstring \
        gettext mcrypt pcntl pdo pdo_mysql soap \
        tokenizer zip ldap gd intl xdebug exif \

	&& rm -rf /var/cache/apk/* \
	&& apk del pcre-dev ${PHPIZE_DEPS} \
	&& chmod +x /entrypoint.sh

COPY .docker/www.conf /usr/local/etc/php-fpm.d/
COPY .docker/docker-php-memory-limit.ini /usr/local/etc/php/conf.d/
COPY .docker/docker-php-ext-xdebug-disabled.ini /usr/local/etc/php/
COPY .docker/docker-php-ext-xdebug-enabled.ini /usr/local/etc/php/

ENTRYPOINT ["/entrypoint.sh"]
