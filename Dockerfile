FROM php:8.4-apache

# Install basic tools
RUN apt-get update && apt-get install -y git unzip \
    && docker-php-ext-install pdo pdo_mysql

# Enable Apache modules
RUN a2enmod rewrite

# Configure Apache to allow .htaccess overrides
RUN sed -i 's|/var/www/html|/var/www/html/public|g' /etc/apache2/sites-available/000-default.conf \
    && sed -i '/<Directory \/var\/www\/>/,/<\/Directory>/ s/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf

## OPcache
RUN docker-php-ext-install opcache
COPY docker/php/opcache.ini /usr/local/etc/php/conf.d/opcache.ini

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www/html

# Copy project files
COPY . .

# Install dependencies
RUN composer install --no-interaction --optimize-autoloader

# Set permissions
RUN chown -R www-data:www-data /var/www/html

# Expose port
EXPOSE 80