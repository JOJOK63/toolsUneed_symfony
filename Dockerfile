FROM php:8.4-apache

# Installer les outils de base
RUN apt-get update && apt-get install -y git unzip \
    && docker-php-ext-install pdo pdo_mysql

# Activer le module Apache
RUN a2enmod rewrite

# Rediriger Apache vers le dossier /public de Symfony
RUN sed -i 's|/var/www/html|/var/www/html/public|g' /etc/apache2/sites-available/000-default.conf

# Installer Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Dossier de travail
WORKDIR /var/www/html

# Copier tout le projet
COPY . .

# Donner les permissions
RUN chown -R www-data:www-data /var/www/html