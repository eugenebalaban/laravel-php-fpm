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

COPY . /var/www/html