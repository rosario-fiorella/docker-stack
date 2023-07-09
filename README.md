# NGINX REVERSE-PROXY PHP-FPM

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
Many tools like **Composer, Xdebug, Git** are already enabled

Next step
```
docker compose up -d
```

Finally
open in browser
- NGINX PHP-FPM http://localhost:8080
- REDIS http://localhost:8081
- PHPMYADMIN http://localhost:8888
- SOLR http://localhost:8983

Enjoi!
