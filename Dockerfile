FROM php:8-fpm

RUN apt-get update && apt-get -y install git \
    # pdo-mysql
    && docker-php-ext-install mysqli pdo pdo_mysql \
    # xdebug
    && pecl install xdebug && docker-php-ext-enable xdebug \
    # php-redis
    && pecl install redis && docker-php-ext-enable redis.so \
    # php-solr
    && apt-get update && apt-get -y install libcurl4-gnutls-dev \
    && apt-get update && apt-get -y install libxml2-dev \
    && pear install pecl/solr && docker-php-ext-enable solr.so \
    # composer
    && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php -r "if (hash_file('sha384', 'composer-setup.php') === '55ce33d7678c5a611085589f1f3ddf8b3c52d662cd01d4ba75c0ee0459970c2200a51f492d557530c71c15d8dba01eae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');" \
    && mv composer.phar /usr/local/bin/composer

USER www-data

WORKDIR /var/www/html
