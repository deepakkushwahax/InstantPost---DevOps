# Install Required PHP Modules for WordPress
sudo apt install php-mysql php-xml php-gd php-curl php-mbstring php-xmlrpc -y

#  Create a MySQL Database and User for WordPress - 
#  Login to MySQL   
mysql -u root -p

#  Create a new database for WordPress
CREATE DATABASE wordpress;

#  Create a new user for WordPress
CREATE USER
'wordpress'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wp_user'@'localhost';
FLUSH PRIVILEGES;
EXIT;

#  Download and Extract WordPress
#  Download the latest version of WordPress
wget https://wordpress.org/latest.tar.gz

#  Extract the downloaded file
tar -xvzf latest.tar.gz

#  Move the extracted files to the Apache root directory
sudo mv wordpress /var/www/html/

#  Set the correct permissions

sudo chown -R www-data:www-data /var/www/html/wordpress
sudo chmod -R 755 /var/www/html/wordpress

#  Configure WordPress
#  Create a copy of the sample configuration file
cd /var/www/html/wordpress
cp wp-config-sample.php wp-config.php

#  Open the configuration file for editing
nano wp-config.php

#  Update the database details
define('DB_NAME', 'wordpress');
define('DB_USER', 'wp_user');
define('DB_PASSWORD', 'password');
define('DB_HOST', 'localhost');

#set correct permissions for wordpress

sudo chown -R www-data:www-data /var/www/site1.com/public_html
sudo chmod -R 755 /var/www/site1.com/public_html

# configure the Apache for WordPress
#  Create a new virtual host configuration file
sudo nano /etc/apache2/sites-available/wordpress.conf 

#restart the apache server
sudo systemctl restart apache2
  
