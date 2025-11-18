FROM php:8.4-fpm

# Install system dependencies, locales, build tools, and PHP extensions
RUN apt-get update && apt-get install -y --no-install-recommends \
    locales locales-all \
    zlib1g-dev libicu-dev libssl-dev git libcurl4-gnutls-dev libxml2-dev zip unzip libzip-dev \
    curl wget autoconf build-essential nano \
 && locale-gen en_US.UTF-8 \
 # Configure and install PHP extensions
 && docker-php-ext-configure intl \
 && docker-php-ext-configure gettext \
 && docker-php-ext-configure zip \
 && docker-php-ext-install intl gettext zip mysqli pdo pdo_mysql opcache \
 # Install PECL extensions redis and solr, then enable them
 && pecl install redis solr \
 && docker-php-ext-enable redis solr \
 # Install PECL xdebug separately and enable it
 && pecl install xdebug \
 && docker-php-ext-enable xdebug \
 # Clean up apt cache to reduce image size
 && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Composer globally in a secure way
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
 && php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
 && php -r "unlink('composer-setup.php');"

# Install global PHP tools via Composer: PHPStan, PHP_CodeSniffer, PHPUnit
RUN composer global require phpstan/phpstan:^1.0 \
 && composer global require squizlabs/php_codesniffer:^3.0 \
 && composer global require phpunit/phpunit:^10.0

# Add Composer global bin directory to PATH to make phpstan, phpcs, phpunit globally available
ENV PATH="/root/.composer/vendor/bin:${PATH}"

# Set the user and working directory as recommended for PHP-FPM containers
USER www-data
WORKDIR /var/www/html
