FROM php:8.2-fpm

RUN apt-get update && apt-get install -y \
 # libs
 locales locales-all zlib1g-dev libicu-dev libssl-dev git libcurl4-gnutls-dev libxml2-dev \
 # locale
 && locale-gen \
 && docker-php-ext-configure intl \
 && docker-php-ext-configure gettext \
 && docker-php-ext-install intl gettext \
 # composer
 && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
 && php composer-setup.php \
 && php -r "unlink('composer-setup.php');" \
 && mv composer.phar /usr/local/bin/composer \
 # pdo-mysql
 && docker-php-ext-install mysqli pdo pdo_mysql \
 # xdebug
 && pecl install xdebug && docker-php-ext-enable xdebug \
 # php-redis
 && pecl install redis && docker-php-ext-enable redis.so \
 # php-solr
 && pecl install solr && docker-php-ext-enable solr.so \
 # opcache
 && docker-php-ext-install opcache

USER www-data

WORKDIR /var/www/html
