# NGINX REVERSE-PROXY PHP-FPM

## REQUIREMENTS
- Docker version 26.1.3, build b72abbb
- Docker Compose version v2.27.0

## DOCKER STACK:
- NGINX REVERSE PROXY
- PHP-FPM
- REDIS
- REDIS-COMMANDER
- MYSQL
- PHPMYADMIN
- SOLR

First step build PHP-FPM image by command:

```
docker image build --progress=plain --no-cache -t php8:0.0.1 .
```
Many tools like **Composer, Xdebug, Git, Opcache** are already enabled

Next step
```
docker compose up -d
```

to stop docker services
```
docker compose down
```

## XDEBUG
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

Enjoi!
