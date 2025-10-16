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
Many tools like **Composer, Curl, Git, Intl, Opcache, PHP_CodeSniffer, PHPStan, PHPUnit, Unzip, Xdebug, Wget, Zip** are already enabled

Next step
```
docker compose up -d
```

to stop docker services
```
docker compose down
```

## TOOLS

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
docker compose down
```
Finally
open in browser
- WORDPRESS http://localhost
- WP-CLI, first enter the container ``docker exec -it wp /bin/bash``, then run from within the container ``wp --help``
- PHPMYADMIN http://localhost:8888

Enjoi!
