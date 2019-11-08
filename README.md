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
sudo apt-get install upgrade
```
### Nastavení MySQL root hesla
**HESLO** nahraďtě heslem pro root MySQL.
```
sudo mysql -u root -p
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'HESLO';
exit
sudo service mysql stop
sudo service mysql start
```
### phpMyAdmin
```
sudo apt-get install phpmyadmin
```
### Skupiny
#### Přidání skupiny 
```
groupadd webuser
```
#### Práva pro skupinu
Otevřít SSHD config
```
nano /etc/ssh/sshd_config
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
## Registrace uživatele
Uživatele zaregistrujte pomocí spuštění scriptu, první parametr udává jméno uživatele a druhý parametr udává heslo uživatele:
```
sh generate_user.sh JMENO HESLO
```
## Soon:
* Přidávání MySQL databáze a uživatele ke generaci.
## Main Contributors:
* [Velda](https://github.com/Veldik/)
