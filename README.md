# NGINX REVERSE-PROXY PHP-FPM

## REQUIREMENTS
- Docker version 28.5.1, build e180ab8
- Docker Compose version v2.40.0

## STACK
- [NGINX + PHP-FPM](#docker-stack)
- [Wordpress + WP-Cli](#wordpress)

## DOCKER STACK
- NGINX REVERSE PROXY
- PHP-FPM
- REDIS
- REDIS-COMMANDER
- MYSQL
- PHPMYADMIN
- SOLR

First step build PHP-FPM image by command:

```
docker image build --progress=plain --no-cache -t php84:0.0.1 .
```
Many tools like **Composer, Curl, Git, Intl, Nano, Opcache, PHPCS, PHPStan, PHPUnit, Unzip, Xdebug, Wget, Zip** are already enabled

Next step
```
docker compose up -d
```

to stop docker services
```
docker compose down
```

## TOOLS
Log in to the Docker container as the ```root``` user.
```
docker exec -it --user root app /bin/bash
```

### Composer
Global installation available here: ```/root/.composer/vendor```
```
composer --version
```

### PHPCS
```
phpcs --version
```

### PHPStan
```
phpstan --version
```

### PHPUnit
```
phpunit --version
```

### XDEBUG
create file **launch.json**
```
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Listen for Xdebug",
            "type": "php",
            "request": "launch",
            "port": 9003,
            "pathMappings": {
                "/var/www/html": "${workspaceRoot}\\src"
            },
            "log": true
        }
    ]
}
```

Finally
open in browser
- ```NGINX PHP-FPM``` http://localhost:8080
- ```REDIS``` http://localhost:8081
- ```PHPMYADMIN``` http://localhost:8888
- ```SOLR``` http://localhost:8983

Check the status of the services
- open url http://localhost:8080/health.php

## WORDPRESS

to start wordpress services 
```
docker compose -f docker-compose-wordpress.yml up -d
```
to stop docker services
```
docker compose -f docker-compose-wordpress.yml down
```
## TOOLS

### PHPCS + WPCS Setup

Access the Composer Docker container by running
```
docker compose -f docker-compose-wordpress.yml run --rm composer bash
```
Check the installed version of composer:
```
composer --version
```
Run the command to install dependencies with Composer:
```
composer install
```
Check the installed version of PHP Code Sniffer with:
```
./vendor/bin/phpcs --version
```
Run PHP Code Sniffer (PHPCS) with the WordPress standard on a specific plugin, for example `my-plugin`:
```
./vendor/bin/phpcs --standard=WordPress ./wp-content/plugins/my-plugin --report=full
```
To automatically fix coding issues, use PHP Code Beautifier and Fixer (PHPCBF):
```
./vendor/bin/phpcbf --standard=WordPress ./wp-content/plugins/my-plugin
```
### WP-CLI
Access the WP-CLI Docker container by running
```
docker exec -it wp-cli /bin/bash
```
then run from within the container
```
wp --help
```

Finally
open in browser
- WORDPRESS http://localhost
- PHPMYADMIN http://localhost:8888

Enjoi!
