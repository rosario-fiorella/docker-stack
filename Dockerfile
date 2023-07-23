FROM php:8-fpm

    # locale-strings
RUN apt-get update && apt-get install -y locales \
    && dpkg-reconfigure locales \
    && apt-get update && apt-get install -y libicu-dev \
	&& docker-php-ext-configure intl \
    && docker-php-ext-install intl \
    && apt-get update && apt-get install -y libonig-dev \
    && docker-php-ext-install -j$(nproc) gettext mbstring \
    # composer
    && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');" \
    && mv composer.phar /usr/local/bin/composer \
    # git
    && apt-get update && apt-get install -y git \
    # pdo-mysql
    && docker-php-ext-install mysqli pdo pdo_mysql \
    # xdebug
    && pecl install xdebug && docker-php-ext-enable xdebug \
    # php-redis
    && pecl install redis && docker-php-ext-enable redis.so \
    # php-solr
    && apt-get update && apt-get install -y libcurl4-gnutls-dev \
    && apt-get update && apt-get install -y libxml2-dev \
    && pecl install solr && docker-php-ext-enable solr.so

USER www-data

WORKDIR /var/www/html
