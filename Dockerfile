FROM php:8.4-apache

RUN apt-get update && apt-get install -y git unzip \
    && docker-php-ext-install pdo pdo_mysql opcache

RUN a2enmod rewrite
RUN sed -i 's|/var/www/html|/var/www/html/public|g' /etc/apache2/sites-available/000-default.conf \
    && sed -i '/<Directory \/var\/www\/>/,/<\/Directory>/ s/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf

COPY docker/php/opcache.ini /usr/local/etc/php/conf.d/opcache.ini
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html
RUN git config --global --add safe.directory /var/www/html

COPY . .

RUN mkdir -p var/cache var/log var/sessions \
    && chmod -R 775 var

RUN composer install --no-interaction --optimize-autoloader

# Entrypoint
COPY docker/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 80
ENTRYPOINT ["/entrypoint.sh"]
