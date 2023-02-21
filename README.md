# AMP

Classic AMP stack, basic docker image with "apache", "mysql", "php" and developer tools enabled by default "composer", "xdebug".


First step build imagev by command:

```
sudo docker image build -t php81:0.0.1 .
```

Next step
```
sudo docker compose up -d
```

Finally
open in browser
- localdev: http://localhost:8080/
- phpmyadmin: http://localhost:8081/

Enjoi!