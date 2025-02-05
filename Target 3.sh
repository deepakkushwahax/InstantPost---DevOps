#Update the /etc/hosts File -

sudo nano /etc/hosts

#Add the following lines:

127.0.0.1   local.example.com

# update Apache's Virtual  Host Configuration File -
sudo nano /etc/apache2/sites-available/local.example.com.conf

#Add the following content:
ServerName local.example.com
ServerAlias www.local.example.com

# to rastart the apache server
sudo systemctl restart apache2