# To enable virtual hosts - 
sudo apt update
sudo apt install apache2 -y
sudo systemctl start apache2
sudo systemctl enable apache2

# Configure  Apache Virtual Hosts
sudo mkdir -p /var/www/site1.com/public_html
sudo mkdir -p /var/www/site2.com/public_html

# set the correct permissions
sudo chown -R $USER:$USER /var/www/site1.com/public_html
sudo chown -R $USER:$USER /var/www/site2.com/public_html

# Create a sample index.html file
echo "<html><body><h1>Welcome to site1.com</h1></body></html>" | sudo tee /var/www/site1.com/public_html/index.html
echo "<html><body><h1>Welcome to site2.com</h1></body></html>" | sudo tee /var/www/site2.com/public_html/index.html

#Configure Apache Virtual Hosts
sudo nano /etc/apache2/sites-available/site1.com.conf

# Add the following content
<virtualhost *:80>
ServerAdmin webmaster@site1.com
ServerName site1.com
    DocumentRoot /var/www/site1.com/public_html
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>

#Enable the Virtual Sites for that we need to run - 
               sudo a2ensite site1.com.conf
               sudo a2ensite site2.com.conf
         And Disable the default site -
               sudo a2dissite 000-default.conf
         Reload the Apache Server - 
               sudo systemctl reload apache2

#Configure DNS - 
sudo nano /etc/hosts

#And add : 
127.0.0.1 site1.com
127.0.0.1 site2.com






  




