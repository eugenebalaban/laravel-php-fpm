FROM php:7.1-fpm-alpine

RUN set -xe \
	&& apk add --no-cache \
		libmcrypt-dev \
		libxml2-dev \
		libintl \
		gettext-dev \

	# Install composer and prestissimo
	&& curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && composer global require "hirak/prestissimo:^0.3" \

    # Install PHP modules
    && docker-php-ext-install bcmath \
        calendar fileinfo iconv json mbstring \
        gettext mcrypt pcntl pdo pdo_mysql soap \
        tokenizer zip

ARG INSTALL_XDEBUG=false
RUN if [ ${INSTALL_XDEBUG} = true ]; then \
    # Install xDebug if it's required
    apk add --no-cache \
        g++ make autoconf \
    && pecl install xdebug-2.5.0 \
    && docker-php-ext-enable xdebug \
    && echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_autostart=0" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.idekey=PHPSTORM" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
;fi

COPY . /var/www/html