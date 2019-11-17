# SimpleHost
Jednoduchý script, na hostování více webů na Apache2 s MySQL na jedné doméně.
*Funguje na Ubuntu Server 18.04*
## Instalace
### LAMP Server
```
sudo apt-get update
sudo apt-get install apache2
sudo apt-get install mysql-server
sudo apt-get install php libapache2-mod-php php-mysql
sudo apt-get upgrade
```
### Nastavení MySQL root hesla
**HESLO** nahraďtě heslem pro root MySQL.
```
sudo mysql -u root -p
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'HESLO';
exit
sudo service mysql stop
sudo service mysql start
sudo mysql -u root -p
# Napište heslo
ALTER USER 'root'@'localhost' IDENTIFIED BY 'HESLO!'; 
exit
```
### phpMyAdmin
#### Stažení phpMyAdmin
```
sudo apt-get install phpmyadmin
```
#### Vytvoření virtuálního hostu pro phpMyAdmin
Nahraďte example.com vaší doménou
```
sudo nano /etc/apache2/sites-available/phpmyadmin.conf
<VirtualHost *:80>
  ServerAdmin webmaster@example.com
  ServerName phpmyadmin.example.com
  DocumentRoot /usr/share/phpmyadmin
  ErrorLog /var/log/apache2/error.log
  CustomLog /var/log/apache2/access.log combined
</VirtualHost>
sudo a2ensite phpmyadmin.conf
sudo systemctl restart apache2
```
### Skupiny
#### Přidání skupiny 
```
sudo groupadd webuser
```
#### Práva pro skupinu
Otevřít SSHD config
```
sudo nano /etc/ssh/sshd_config
```
Ke konci dokumentu pŕidat hashtag před
```
Subsystem sftp /usr/lib/openssh/sftp-server
```
A přidat kus kódu za zakomentovanou část (prostě za ten řádek, kam jsme přidali hashtag)
```
Subsystem sftp internal-sftp
Match Group webuser
    ChrootDirectory %h
    X11Forwarding no
    AllowTcpForwarding no
    ForceCommand internal-sftp
```
A restartujte SSHD
```
sudo service ssh restart
```
### Instalace skritpu
Stáhněte skript pomocí:
```
wget https://raw.githubusercontent.com/Veldik/simplehost/master/generate_user.sh
```
Upravte 4 a 5 řádek na vaše heslo a vaší doménu
```
nano generate_user.sh
```
## Registrace uživatele
Uživatele zaregistrujte pomocí spuštění scriptu, první parametr udává jméno uživatele a druhý parametr udává heslo uživatele:
```
sudo sh generate_user.sh JMENO HESLO
```
## Main Contributors:
* [Velda](https://github.com/Veldik/)
