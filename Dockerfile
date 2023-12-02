# Use an official PHP runtime as a parent image
FROM php:7.4-apache

# Install MySQL extension for PHP
RUN docker-php-ext-install mysqli pdo_mysql

# Install unzip to extract phpMyAdmin
RUN apt-get update && apt-get install -y unzip

# Set up Apache configurations if needed
# COPY apache-config.conf /etc/apache2/sites-available/000-default.conf

# Copy PHP application files into the image
COPY . /var/www/html/myapp

# Download and install phpMyAdmin
RUN mkdir /var/www/html/phpmyadmin && \
    curl -L https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.zip -o /tmp/phpmyadmin.zip && \
    unzip /tmp/phpmyadmin.zip -d /var/www/html/phpmyadmin && \
    mv /var/www/html/phpmyadmin/phpMyAdmin-*/* /var/www/html/phpmyadmin && \
    rm -rf /var/www/html/phpmyadmin/phpMyAdmin-*

# Expose ports for Apache and phpMyAdmin
EXPOSE 80
EXPOSE 8181

# Start Apache when the container launches
CMD ["apache2-foreground"]
