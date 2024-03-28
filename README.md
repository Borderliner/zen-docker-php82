## Docker stack with PHP 8.2 (inc. composer & nodejs), Nginx, Redis, Adminer

### Usage
Enter `docker-compose up` inside this directory to setup your docker containers and start the main PHP container. Everything inside `www` folder will be the root of nginx.

### Config
Change `etc/nginx.conf` value of `root` to the root public folder you want. App will be served from here (typically called `public` folder in frameworks like Laravel)

### Paths
Nginx URL: http://localhost

Adminer URL: http://localhost:8080

### Database Info
Creates 3 empty databases:
1. app_dev
2. app_prod
3. app_test

Creates 2 users:
1. admin:admin
2. root:root

### PHP Modules
- zip
- simplexml
- xml
- mbstring
- intl
- bcmath
- mcrypt
- oauth
- gd
- pdo
- pdo_mysql
- mysqli
- redis
- yaml
- xdebug
- imagick
- memcache-8.2
- xdebug-3.3.1
- ioncube
- composer

## Note:
If you're developing inside the container
