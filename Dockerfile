FROM php:8.1-fpm

# Copy composer.lock and composer.json
COPY composer.lock composer.json /var/www/

# Set working directory
WORKDIR /var/www

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    locales \
    zip \
    jpegoptim optipng pngquant gifsicle \
    vim \
    unzip \
    git \
    curl \
    libonig-dev \
    libzip-dev \
    gnupg \
    apt-transport-https \
    lsb-release \
    ca-certificates

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install extensions
RUN docker-php-ext-install pdo_mysql mbstring zip exif pcntl
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install gd

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copy existing application directory contents
COPY . /var/www
WORKDIR /var/www

# Add the NodeSource APT repository for Node 16
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash -

# Install Node.js and npm
RUN apt-get install -y nodejs
RUN apt-get install -y npm
RUN apt-get install -y vite

# https://stackoverflow.com/a/72810837
# RUN npm install
RUN npm install --save-dev vite laravel-vite-plugin
RUN npm install --save-dev @vitejs/plugin-vue
# https://github.com/NVlabs/instant-ngp/discussions/300#discussion-3909942
# ENV QT_QPA_PLATFORM offscreen
RUN npm run build

# Add user for laravel application
RUN groupadd -g 1000 www
RUN useradd -u 1000 -ms /bin/bash -g www www

# Copy existing application directory permissions
COPY --chown=www:www . /var/www

# Change current user to www
USER www

# Final touches for php
# RUN php artisan key:generate
# RUN php artisan config:cache
# RUN php artisan storage:link
# RUN php artisan migrate --force
# RUN php artisan horizon:install
# RUN php artisan horizon:publish
# RUN php artisan horizon

# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["php-fpm"]
