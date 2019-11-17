#!/bin/bash
nick=$1 # Nick is first atribut of command
pass=$2 # Password is second atribut of command
mysqlrootpass=HESLO # MySQL root password
domain=example.com # Define domain
# Making home dirrectory
webDir="/home/$nick/public_html"
sudo mkdir -p $webDir
# Adding user
sudo useradd -d /home/$nick $nick
echo "$nick:$pass" | chpasswd
sudo usermod -g webuser $nick
sudo chown root:root /home/$nick
sudo chmod 755 /home/$nick
sudo chown $nick:$nick $webDir
# Setting up hosting
sitesAvailable="/etc/apache2/sites-available/$nick.conf"
echo "<VirtualHost *:80>
  ServerAdmin webmaster@${domain}
  ServerName ${nick}.${domain}
  DocumentRoot $webDir
  ErrorLog /var/log/apache2/error.log
  CustomLog /var/log/apache2/access.log combined
    <Directory "$webDir">
        Require all granted
    </Directory>
</VirtualHost>" > $sitesAvailable
sudo a2ensite $nick.conf
sudo systemctl restart apache2
# Creating MySQL user and database
mysql -uroot -p${mysqlrootpass}<<ENDMYSQL
CREATE DATABASE ${nick};
CREATE USER '${nick}'@'localhost' IDENTIFIED BY '${pass}';
GRANT ALL PRIVILEGES ON ${nick}.* TO '${nick}'@'localhost';
FLUSH PRIVILEGES;
ENDMYSQL
