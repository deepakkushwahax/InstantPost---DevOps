#!/bin/bash

# Exit on any error
set -e

# Update system packages
echo "Updating system packages..."
sudo apt update && sudo apt upgrade -y

# Install Apache
echo "Installing Apache..."
sudo apt install apache2 -y

# Start and enable Apache
echo "Starting and enabling Apache..."
sudo systemctl start apache2
sudo systemctl enable apache2

# Install MySQL
echo "Installing MySQL..."
sudo apt install mysql-server -y

# Start and enable MySQL
echo "Starting and enabling MySQL..."
sudo systemctl start mysql
sudo systemctl enable mysql

# Secure MySQL installation
echo "Securing MySQL installation..."
sudo mysql_secure_installation

# Install PHP and required modules
echo "Installing PHP..."
sudo apt install php libapache2-mod-php php-mysql -y

# Restart Apache to enable PHP
echo "Restarting Apache to enable PHP..."
sudo systemctl restart apache2

# Install Python 3 and pip
echo "Installing Python 3 and pip..."
sudo apt install python3 python3-pip -y

# Install Node.js and npm
echo "Installing Node.js and npm..."
sudo apt install nodejs npm -y

# Verify installations
echo "Verifying Apache installation..."
apache2 -v
echo "Verifying MySQL installation..."
mysql --version
echo "Verifying PHP installation..."
php -v
echo "Verifying Python installation..."
python3 --version
echo "Verifying Node.js installation..."
node -v

# Create a test PHP file for verification
echo "Creating test PHP file for Apache..."
echo "<?php phpinfo(); ?>" | sudo tee /var/www/html/info.php

# Finish
echo "Installation complete! You can test your server by visiting http://<VM_IP>/info.php for PHP info page."

# Cleanup - Remove PHP info file
echo "Cleaning up..."
sudo rm /var/www/html/info.php

# Show disk usage for reference
echo "Disk usage:"
df -h

echo "Setup completed successfully!"