# Change XDebug version if 7.4 is not desired
FROM php:8.2-fpm

# Core Dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
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
    ioncube \
    @composer

# Install NodeJS
ARG NODE_VERSION=20.12.0
RUN curl https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz | tar -xz -C /usr/local --strip-components 1

WORKDIR /app
RUN usermod -u 1000 www-data
# RUN chmod 777 /app # Try removing this if you have permission issues, but I don't really recommend it.
