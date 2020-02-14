#!/bin/sh
sudo -i

echo "---------- INSTALLING WORDPRESS WILL BE STARTED -----------"
#echo "------------------- Update The OS First -------------------"
#yum update -y

echo "------------ Downloading Supporting Environment -----------"
cd /tmp/config
echo "Installing unzip, yum-utils, vim, wget"
yum install -y unzip yum-utils vim wget
echo "Unzipping file configuration"
unzip config.zip
echo "Disabling SELinux"
mv SELinux /etc/selinux/config
echo "Removing zip file old configuration"
rm config.zip

echo "-------------- Installing Apache Web Server ---------------"
echo "Installing HTTPD"
yum install -y httpd
echo "Download firewall"
wget http://mirror.centos.org/centos/7/updates/x86_64/Packages/firewalld-0.6.3-2.el7_7.2.noarch.rpm
echo "Firewall setting"
firewall-cmd --permanent --add-service=http
firewall-cmd --reload
echo "Start Apache web server"
systemctl start httpd
echo "Enable httpd"
systemctl enable httpd

echo "-------------------- Installing PHP 7 ---------------------"
echo "Adding PHP 7 repository"
yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum install -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm
yum-config-manager --enable remi-php74
yum install -y php php-mysql
echo "Restart httpd"
systemctl restart httpd

echo "------------------- Installing MariaDB --------------------"
#concatenate files, gpg: gnu privacy guard (securely encrypts files)
#set to 1: verify the authenticity of the packages by checking the GPG signature
#passing multiple lines
cat <<EOT >> /etc/yum.repos.d/mariadb.repo
[mariadb]
name = MariaDB
baseurl = http://yum.mariadb.org/10.3/rhel7-amd64
gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB
gpgcheck=1
EOT
echo "Install mariadb"
yum install -y mariadb-server mariadb
echo "Copy to overwrite my.cnf without confirmation"
mkdir /etc/mysql
yes | cp -rf /tmp/config/my.cnf /etc/mysql/
echo "Firewall setting"
firewall-cmd --permanent --add-service=mysql
firewall-cmd --reload
echo "Restart httpd"
systemctl restart httpd
echo "Start mariadb"
systemctl start mariadb
echo "Enable mariadb from it start at the boot time"
systemctl enable mariadb

echo "mysql_secure_installation (root can't be access in the other localhost)"
echo "Install expect for automating mysql_secure_installation"
yum install -y expect
echo "Change default mysql password to abc"
mysqladmin -u root password 'abc'
MYSQL_ROOT_PASSWORD=abc

#expect: wait for inputs, spawn: start a program, send: sending a reply, eof: end of file
#-c : commands (can executed multiple lines)
SECURE_MYSQL=$(expect -c "
set timeout 10
spawn mysql_secure_installation
expect \"Enter current password for root (enter for none):\"
send \"$MYSQL\r\"
expect \"Set root password?\"
send \"y\r\"
expect \"New password:\"
send \"$MYSQL_ROOT_PASSWORD\r\"
expect \"Re-enter new password:\"
send \"$MYSQL_ROOT_PASSWORD\r\"
expect \"Remove anonymous users?\"
send \"y\r\"
expect \"Disallow root login remotely?\"
send \"y\r\"
expect \"Remove test database and access to it?\"
send \"y\r\"
expect \"Reload privilege tables now?\"
send \"y\r\"
expect eof
")
echo "$SECURE_MYSQL"

echo "------- Setting MariaDB as a database for Wordpress--------"
echo "Create a database for wordpress"
#passing file or directory
mysql -u root -pabc < /tmp/config/setup.sql

echo "------------------ Installing Wordpress -------------------"
cd /tmp/config
echo "Download and install Wordpress"
wget https://wordpress.org/latest.tar.gz
echo "Extracting Wordpress"
#xf: tar extract, v: verbose
tar -xvf latest.tar.gz
echo "Copying Wordpress to Apache public folder"
cp -rf wordpress/* /var/www/html/
echo "Configuring wordpress"
mv /tmp/config/wp-config.php /var/www/html/
echo "Change Wordpress and Apache ownership"
chown -R apache:apache /var/www/html/
echo "Change access permission"
chmod -R 755 /var/www/html/
echo "Restart httpd"
systemctl restart httpd

echo "-------------- Successful Installation -----------------"
