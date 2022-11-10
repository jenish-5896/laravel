FROM maxtietz/php8.1-fpm
MAINTAINER jenish.com
ENV TZ="Asia/Kathmandu"
# Set working directory
WORKDIR /var/www/html/
# For time issue otherwise cannot update/install in container
RUN echo "Acquire::Check-Valid-Until \"false\";\nAcquire::Check-Date \"false\";" | cat > /etc/apt/apt.conf.d/10no--check-valid-until
# Install dependencies
RUN apt update && apt-get install -y \
    git \
    vim \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    libjpeg-dev \
    zip \
    unzip \
    build-essential \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    locales \
    jpegoptim optipng pngquant gifsicle \
    lua-zlib-dev \
    libmemcached-dev \
    imagemagick libmagickwand-dev --no-install-recommends
RUN docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg

RUN pecl install imagick
RUN docker-php-ext-enable imagick
RUN apt-get clean && rm -rf /var/lib/apt/lists/*
# Install PHP extensions
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd xml iconv simplexml zip
#COPY --from=composer:latest /usr/local/bin/composer /usr/local/bin/composer
# Install composer

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

COPY .  /var/www/html
RUN composer install --no-dev --optimize-autoloader
RUN chmod -R 777 /var/www/html/public/*
RUN chmod -R 777 /var/www/html/storage/*
RUN chmod -R 777 /var/www/html/storage/logs
