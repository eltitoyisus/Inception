#!/bin/sh

echo "Waiting for MariaDB to be ready..."
until nc -z mariadb 3306; do
    echo "MariaDB is unavailable - sleeping"
    sleep 2
done
echo "MariaDB is up!"

echo "Waiting for Redis to be ready..."
until nc -z redis 6379; do
    echo "Redis is unavailable - sleeping"
    sleep 2
done
echo "Redis is up!"

sleep 5

if ! wp core is-installed --path=/var/www/html --allow-root 2>/dev/null; then
    echo "Installing WordPress..."
    
    wp core install \
        --path=/var/www/html \
        --url="https://${DOMAIN_NAME}" \
        --title="Inception WordPress" \
        --admin_user="${WP_ADMIN_USER}" \
        --admin_password="${WP_ADMIN_PASSWORD}" \
        --admin_email="${WP_ADMIN_EMAIL}" \
        --allow-root
    
    echo "WordPress installed successfully!"
    
    echo "Creating additional WordPress user..."
    wp user create \
        "${WP_USER}" \
        "${WP_USER_EMAIL}" \
        --role=author \
        --user_pass="${WP_USER_PASSWORD}" \
        --path=/var/www/html \
        --allow-root
    
    echo "Additional user created successfully!"
    
    echo "Installing Redis Object Cache plugin..."
    wp plugin install redis-cache --activate --path=/var/www/html --allow-root
    
    echo "Enabling Redis cache..."
    wp redis enable --path=/var/www/html --allow-root
    
    echo "Redis cache configured successfully!"
    
    echo "Installing WordPress theme..."
    wp theme install astra --activate --path=/var/www/html --allow-root
    
    echo "WordPress theme installed and activated successfully!"
else
    echo "WordPress is already installed, skipping installation..."
fi

echo "Starting PHP-FPM..."
exec php-fpm83 -F
