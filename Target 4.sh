#!/bin/bash

# 1. Update /etc/hosts
echo "127.0.0.1   local.test.com" | sudo tee -a /etc/hosts

# 2. Set up second WordPress site (local.test.com)
cd /var/www
sudo mkdir -p test.com/public_html
sudo chown -R $USER:$USER test.com/public_html

# Download WordPress
cd /var/www/test.com/public_html
wp core download

# Create wp-config.php
wp config create --dbname=testdb --dbuser=testuser --dbpass=testpassword --dbhost=localhost --path=/var/www/test.com/public_html

# Set permissions
sudo chown -R www-data:www-data /var/www/test.com/public_html
sudo chmod -R 755 /var/www/test.com/public_html

# 3. Set up Apache Virtual Host
sudo tee /etc/apache2/sites-available/test.com.conf > /dev/null <<EOL
<VirtualHost *:80>
    ServerAdmin webmaster@test.com
    ServerName local.test.com
    DocumentRoot /var/www/test.com/public_html
    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined

    <Directory /var/www/test.com/public_html>
        AllowOverride All
    </Directory>
</VirtualHost>
EOL

# Enable site and reload Apache
sudo a2ensite test.com.conf
sudo systemctl restart apache2

# 4. Create MySQL database and user
sudo mysql -u root -p <<MYSQL_SCRIPT
CREATE DATABASE testdb;
CREATE USER 'testuser'@'localhost' IDENTIFIED BY 'testpassword';
GRANT ALL PRIVILEGES ON testdb.* TO 'testuser'@'localhost';
FLUSH PRIVILEGES;
MYSQL_SCRIPT

# 5. Install WordPress using wp-cli
cd /var/www/test.com/public_html
wp core install --url="http://local.test.com" --title="Test Site" --admin_user="admin" --admin_password="adminpassword" --admin_email="admin@test.com"

# 6. Set WordPress home and site URL
wp option update home "http://local.test.com"
wp option update siteurl "http://local.test.com"

echo "WordPress setup complete for local.test.com!"