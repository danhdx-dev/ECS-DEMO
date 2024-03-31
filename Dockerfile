# Sử dụng PHP 8.2 image làm base
FROM php:8.2-fpm

# Cài đặt các dependencies cần thiết
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libpq-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev

# Cài đặt Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Cài đặt PHP extensions
RUN docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install -j$(nproc) gd pdo pdo_mysql mysqli zip

# Thiết lập thư mục làm việc
WORKDIR /var/www/html

# Copy các file cần thiết của Laravel vào image
COPY . .

# Cài đặt các dependencies của Laravel bằng Composer
RUN cp .env.example .env
# RUN php artisan key:generate
RUN composer install --no-scripts --no-autoloader
RUN chmod 777 -R storage/
# CMD chạy các lệnh để khởi động dự án Laravel
CMD php-fpm
