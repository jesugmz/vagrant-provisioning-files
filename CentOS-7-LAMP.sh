#!/bin/bash

#
# CentOS 7 LAMP stack.
#
# Apache (2.4 + MPM prefork)/MariaDB (10.1)/PHP (5.6 + mod_php) with MariaDB official repo.
# Pay attention, firewalld is disabled for agile development.
#

# EPEL repo & tools
yum install -y epel-release git htop vim wget

# MariaDB repo
touch /etc/yum.repos.d/MariaDB.repo
echo '[mariadb]' >> /etc/yum.repos.d/MariaDB.repo
echo 'name=MariaDB' >> /etc/yum.repos.d/MariaDB.repo
echo 'baseurl=http://yum.mariadb.org/10.1/centos7-amd64' >> /etc/yum.repos.d/MariaDB.repo
echo 'gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB' >> /etc/yum.repos.d/MariaDB.repo
echo 'gpgcheck=1' >> /etc/yum.repos.d/MariaDB.repo
echo 'enabled=1' >> /etc/yum.repos.d/MariaDB.repo
rpm --import https://yum.mariadb.org/RPM-GPG-KEY-MariaDB

# Remi repo
wget http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
rpm -Uvh remi-release-7.rpm
rm -f remi-release-7.rpm
# Enable remi repo
sed -i '9 s|enabled=0|enabled=1|' /etc/yum.repos.d/remi.repo
# Enable PHP 5.6
sed -i '27 s|enabled=0|enabled=1|' /etc/yum.repos.d/remi.repo

# Install services
yum install -y MariaDB-server MariaDB-client httpd php php-cli php-mysql

# Several PHP configurations
sed -i 's@error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT@error_reporting = E_ALL@' /etc/php.ini
sed -i 's|display_errors = Off|display_errors = On|' /etc/php.ini
sed -i 's|;date.timezone =|date.timezone = "Europe/Madrid"|' /etc/php.ini
sed -i 's|;cgi.fix_pathinfo = 1|cgi.fix_pathinfo = 0|' /etc/php.ini
sed -i 's|expose_php = on|expose_php = off|' /etc/php.ini

# Add services to start on boot
systemctl enable httpd
systemctl enable mariadb

# Disable firewall on boot (be careful)
systemctl disable firewalld

# Start services
systemctl start httpd
systemctl start mariadb

# Stop firewall (be careful)
systemctl stop firewalld

# mysql_secure_installation
mysql -u root <<-EOF
UPDATE mysql.user SET Password=PASSWORD('vagrant') WHERE User='root';
DELETE FROM mysql.user WHERE User='';
FLUSH PRIVILEGES;
EOF

# Apache permissions for document root
chown -R apache:apache /var/www/html
chmod -R 755 /var/www/html

# PHP info file
touch /var/www/html/phpinfo.php
echo '<?php phpinfo();' >> /var/www/html/phpinfo.php
