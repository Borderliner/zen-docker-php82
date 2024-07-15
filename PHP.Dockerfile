# Change XDebug version if 7.4 is not desired
FROM php:8.2-fpm

# Core Dependencies
RUN apt-get update && apt-get install -y \
    git \
    gnupg2 \
    procps \
    curl \
    wget \
    zip \
    unzip \
    libzip-dev \
    libicu-dev \
    libxml2-dev \
    libonig-dev

# Extension dependencies
RUN apt-get update && apt-get install -y \
    # gd
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    # Memcached
    libmemcached-dev \
    libssl-dev \
    zlib1g-dev

# For Imagick there is no need to install recommended packages
RUN apt-get update && apt-get install -y libmagickwand-dev --no-install-recommends

# https://github.com/mlocati/docker-php-extension-installer
RUN curl -sSLf \
        -o /usr/local/bin/install-php-extensions \
        https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions && \
    chmod +x /usr/local/bin/install-php-extensions

# Install extensions
RUN install-php-extensions \
    zip \
    simplexml \
    xml \
    mbstring \
    intl \
    bcmath \
    mcrypt \
    oauth \
    gd \
    pdo \
    pdo_mysql \
    mysqli \
    redis \
    yaml \
    xdebug \
    imagick \
    # Check versions here: https://pecl.php.net/package-changelog.php?package=memcache
    memcache-8.2 \
    # Check versions here: https://pecl.php.net/package-changelog.php?package=xdebug
    xdebug-3.3.1 \
    @composer

#### IonCube Automatic Install
# RUN install-php-extensions ioncube
#### IonCube Manual Install
# RUN mkdir /shared; echo "export PHP_EXT_DIR=`php-config --extension-dir`" >> /shared/env
# ADD ioncube_loader_lin_8.2.so /shared/ioncube_loader_lin_8.2.so
# RUN . /shared/env; cp /shared/ioncube_loader_lin_8.2.so $PHP_EXT_DIR
#### IonCube is by default shared in /shared

# Install NodeJS
ARG NODE_VERSION
ARG NODE_FILENAME=node-v$NODE_VERSION-linux-x64.tar.gz
ARG NODE_URL=https://nodejs.org/dist/v$NODE_VERSION/$NODE_FILENAME
RUN curl $NODE_URL | tar -xz -C /usr/local --strip-components 1

# Cleanup
RUN rm -f NODE_FILENAME
RUN apt-get autopurge && apt-get clean

WORKDIR /app

RUN usermod -u 1000 www-data

### Laravel ###
# RUN chown -R $USER:www-data storage && chown -R $USER:www-data bootstrap/cache && chmod -R 775 storage && chmod -R 775 bootstrap/cache
# RUN composer install
# RUN npm install
