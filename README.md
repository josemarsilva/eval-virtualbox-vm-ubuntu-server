# eval-virtualbox-vm
Evaluation Virtual Box VM - Ubuntu 18.04

---
## 1. Introduction

Evaluation **Virtual Box VM** is a guide project to install, configure and manage a lot of softwares into a **Ubuntu 18.04** VM in Virtual Box.


### 1.1. Deploy Diagram

![DeployDiagram - Context - EvalVirtualboxVmUbuntuServer](doc/images/DeployDiagram%20-%20Context%20-%20EvalVirtualboxVmUbuntuServer.png)

### 1.2. Deploy Installation Indexes

High priority:

* [NodeJs](#31-nodejs)
* [Python 3.6 - Pip3 - Jupyter Notebook](#33-python-36-jupyter-notebook-numpy)
* [Jupyter Notebook](#33-python-36-jupyter-notebook-numpy)
* [Transmission/Torrent Client](#320-transmission-cli)
* [Docker Images, Dockerfile, Compose, Command Line](#4-docker)
* [Docker & Docker Composer - Installation](#41-docker---installation)

Normal:

* [Docker Composer - MySQL e phpMyAdmin](#43-docker-composer---mysql-57--php-myadmin)
* [Docker Composer - PostgreSQL e pgAdmin4](#44-docker-composer---postgresql-96-pgadmin4)
* [Docker Composer - Wordpress](#45-docker-composer---wordpress-mysql-57)
* [Docker - Jenkins](#47-docker---jenkins)
* [Docker Composer - MongoDB](#48-docker-composer---mongodb)
* [Docker Composer - MongoDB](#49-docker-composer---redmine)
* [Docker Composer - Kafka](#410-docker-composer---kafka)
* [Docker Composer - Cassandra](#411-docker-composer---cassandra)
* [Docker Composer - MQ-Series](#412-docker-composer---mq-series)
* [Docker Composer - SugarCRM](#413-docker-composer---sugarcrm)
* [Docker -  Bamboo Server](#414-docker---bamboo-server)
* [Docker - Ubuntu server](#415-docker---ubuntu-server)
* [Docker - Chef-server](#416-docker---chef---server)
* [Hercules](#319-hercules-mainframe-emulator)

Low Priority:

* [Java 8 - JDK](#32-java-8-jdk)
* [UFW](#34-ufw)
* [PHP 7.3](#35-php-73)
* [MySQL](#36-mysql)
* [PostgreSQL](#37-postgresql)
* [MongoDB](#38-mongodb)
* [Casandra](#39-casandra)
* [Apache2](#310-apache2)
* [NGINX](#311-nginx)
* [Tomcat](#312-tomcat)
* [Jenkins](#313-jenkins)
* [Zabbix](#314-zabbix)
* [NMON](#315-nmon)
* [Kubernets](#316-kubernets)
* [Wordpress](#317-wordpress)

Very Priority:

* [Pentaho Community (Work in Progress)](#318-pentaho-community)
* [Docker Composer - Oracle (Work in Progress)](#46-docker-composer---oracle-database)


---
## 2. Configuration Managment

### 2.1. Authentication Credentials
* ubuntu/ubuntu

### 2.2. Installing Virtual Box Guest Additions

* https://www.virtualzero.net/blog/how-to-install-virtualbox-guest-additions-in-ubuntu-server-18.04-lts


---
#### 2.3. Network Configurations
* Host -> Guest (127.0.0.1)
* Port(s): Apache2/NGINX(80,81,443), OpenSSH/SCP/FTP(22,21), Jenkins/Tomcat/(8080,8081), JupyterNotebook(8888), PostgreSQL(5432), MySQL(3306), Casandra(7000,7199,9042,9160), MongoDB(27017,27018,27019), pgAdmin4(16543), Rails/Redmine(3000)
* [Passo a passo da configuração da rede do Virtual Box](doc/README_NetworkConfiguration_StepByStep.md)




---
### 3. Installed Softwares and Packages

#### 3.1. NodeJs

#### a. Installation procedure

```sh
sudo apt update -y
sudo apt install npm
npm -v # 3.5.2
```

---
#### 3.2. Java 8 JDK

#### a. Installation procedure

```sh
sudo apt install openjdk-8-jdk -y
```


---
#### 3.3. Python 3.6, Jupyter Notebook, Numpy

#### a. Installation procedure

* Step-by-Step installation **Python**

```sh
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt-get update
sudo apt-get install python3.6 -y
sudo apt install python-pip -y
python
>> import sys
>> print(sys.version)
>> quit()
pip list
```

* Step-by-Step installation **Numpy**

```sh
sudo pip install numpy
sudo pip install requests
```

* Step-by-Step installation **Jupyter Notebook** 

* [Reading Pre-requisites before installation](https://www.digitalocean.com/community/tutorials/como-configurar-o-jupyter-notebook-com-python-3-no-ubuntu-18-04-pt)

```sh
# Install Python, Pip3 e VirtualEnv ...
sudo apt update
sudo apt install python3-pip python3-dev -y
sudo -H pip3 install --upgrade pip
sudo -H pip3 install virtualenv

# O flag -H garante politica de seguranca configure a variavel home para o diretório do usuário
mkdir ~/GitHome ; cd ~/GitHome
mkdir ~/GitHome/py-jupyter-env
cd    ~/GitHome/py-jupyter-env
virtualenv venv # criando o ambiente virtual chamado 'py-jupyter-env'
source venv/bin/activate

# Install Jupyter no ambiente criado pelo virtualenv
pip install jupyter

# Generating Jupyter Notebook configuration file
jupyter notebook --generate-config

# Enabling 
vim /home/ubuntu/.jupyter/jupyter_notebook_config.py
  :
c.NotebookApp.allow_origin = '*' #allow all origins
c.NotebookApp.ip = '0.0.0.0' # listen on all IPs
  :

# Starting Jupyter Notebook
cd    ~/GitHome/py-jupyter-env
source venv/bin/activate
jupyter notebook
```


---
#### 3.4. UFW

#### a. Installation procedure

* [Reading Pre-requisites before installation](http://wiki.ubuntu-br.org/UFW)

```sh
sudo systemctl start  ufw
sudo systemctl status ufw
sudo systemctl enable ufw

sudo ufw status
sudo ufw status verbose
sudo ufw app list
sudo ufw allow 'OpenSSH' # port 22
sudo ufw allow 80/tcp    # Apache2, NGINX
sudo ufw allow 8080/tcp  # Jenkins/Tomcat/microk8s
sudo ufw allow 8081/tcp  # Jenkins/Tomcat/microk8s
sudo ufw allow 3306/tcp  # MySQL
sudo ufw allow 5432/tcp  # PostgreSQL
sudo ufw allow 8888/tcp  # JupyterNotebook
sudo ufw allow 27017/tcp # MongoDB mongod/mongos
sudo ufw allow 27018/tcp # MongoDB shardsrv
sudo ufw allow 27019/tcp # MongoDB configsrv
sudo ufw allow 18083/tcp # VBoxWebService
sudo ufw status verbose
```

---
#### 3.5. PHP 7.3

#### a. Installation procedure

* [Reading Pre-requisites before installation](https://www.rosehosting.com/blog/how-to-install-php-7-3-on-ubuntu-18-04/)

```sh
sudo apt upgrade -y
sudo apt update -y
sudo apt install software-properties-common
sudo apt install python-software-properties
sudo add-apt-repository ppa:ondrej/php
  :
  Press [ENTER] to continue or Ctrl-c to cancel adding it. [ENTER]
  :

sudo apt update -y
sudo apt-cache search php7.3
sudo apt install php7.3 php7.3-cli php7.3-common php7.3-opcache php7.3-curl php7.3-mbstring php7.3-mysql php7.3-zip php7.3-xml -y
php -v  # Verificar a versao 7.3
php --ini | grep "Loaded Configuration File"
sudo vim /etc/php/7.3/cli/php.ini
sudo vim /var/www/html/phpinfo.php
  :
<?php phpinfo(); ?>
  :

# Open url
http://IP-ADDRESS/phpinfo.php

# Stop and disable
sudo systemctl stop    apache2
sudo systemctl disable apache2
sudo systemctl status  apache2
```

---
#### 3.6. MySQL 

#### a. Installation procedure

```sh
sudo apt install mysql-server -y
sudo mysql_secure_installation # password: password
# setup VALIDATE PASSWORD plugin? N
# New password: password
# Re-enter new password: password
# Remove anonymous users? Y
# Disallow root login remotely? N
# Remove test database ? N
# Reload privilege tables now? Y
sudo vim /etc/mysql/mysql.conf.d/mysqld.cnf
  :
bind-address            = 0.0.0.0
  :

sudo systemctl start  mysql.service
sudo systemctl status mysql.service
sudo mysql
mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
6 rows in set (0.27 sec)
mysql> CREATE USER 'user'@'%' IDENTIFIED BY 'password';
mysql> GRANT ALL PRIVILEGES ON *.* TO 'user'@'%' IDENTIFIED BY 'password' WITH GRANT OPTION;
mysql> ALTER USER user IDENTIFIED BY 'password';
mysql> FLUSH PRIVILEGES;
mysql> USE mysql
mysql> select Host, User from user;
+-----------+------------------+
| Host      | User             |
+-----------+------------------+
| %         | root             |
| %         | user             |
| localhost | debian-sys-maint |
| localhost | mysql.session    |
| localhost | mysql.sys        |
| localhost | root             |
+-----------+------------------+
mysql> EXIT
sudo systemctl stop    mysql.service
sudo systemctl disable mysql.service
```

#### b. Configuration management

* MySQL - port: 3306; User/Password: 'user'@'%' / 'password'


---
#### 3.7. PostgreSQL

#### a. Installation procedure

```sh
sudo apt install postgresql postgresql-contrib -y
sudo systemctl start  postgresql
sudo systemctl status postgresql
sudo -u postgres psql -c "SELECT version();"
sudo su - postgres
$ psql
postgres=# \l postgres
                               List of databases
   Name   |  Owner   | Encoding |   Collate   |    Ctype    | Access privileges
----------+----------+----------+-------------+-------------+------------------
 postgres | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 |
(1 row)
postgres=# \q
postgres=# exit
sudo systemctl stop    postgresql
sudo systemctl disable postgresql
```


---
#### 3.8. MongoDB

#### a. Installation procedure

```sh
sudo apt install -y mongodb 
sudo systemctl start   mongodb
sudo systemctl status  mongodb
mongo --eval 'db.runCommand({ connectionStatus: 1 })'
sudo systemctl stop    mongodb
sudo systemctl disable mongodb
```

---
#### 3.9. Casandra

#### a. Installation procedure

* [Reading Pre-requisites before installation](http://cassandra.apache.org/download/) 

```sh
echo "deb http://www.apache.org/dist/cassandra/debian 311x main" | sudo tee -a /etc/apt/sources.list.d/cassandra.sources.list
curl https://www.apache.org/dist/cassandra/KEYS | sudo apt-key add -
sudo apt-get update
sudo apt-key adv --keyserver pool.sks-keyservers.net --recv-key A278B781FE4B2BDA
```

* Step-by-Step Casandra installation and post installation health check

```sh
sudo apt-get   install cassandra -y
sudo systemctl start   cassandra
sudo systemctl status  cassandra
nodetool status
cqlsh 
  cqsql> SELECT cluster_name, listen_address FROM system.local;
  cqsql> exit
sudo systemctl stop    cassandra
sudo systemctl disable cassandra
```

---
#### 3.10. Apache2

#### a. Installation procedure

* [Reading Pre-requisites before installation](https://www.digitalocean.com/community/tutorials/how-to-install-the-apache-web-server-on-ubuntu-18-04-quickstart)

```sh
sudo apt-get   install apache2 -y
sudo apt       install wget
sudo systemctl start   apache2
sudo systemctl status  apache2
cd /tmp ; wget "http://localhost" ; cd ~ ; cat /tmp/index.html ; rm -f /tmp/index.html
sudo systemctl stop    apache2
sudo systemctl disable apache2
```

---
#### 3.11. NGINX

#### a. Installation procedure

* [Reading Pre-requisites before installation](https://www.digitalocean.com/community/tutorials/como-instalar-o-nginx-no-ubuntu-18-04-pt)

```sh
sudo apt install nginx -y
sudo ufw app list
sudo ufw allow 'Nginx HTTP'
sudo ufw status
sudo systemctl start  nginx
sudo systemctl status nginx
cd /tmp ; wget "http://localhost" ; cd ~ ; cat /tmp/index.html
sudo systemctl stop    nginx
sudo systemctl disable nginx
```

---
#### 3.12. Tomcat

#### a. Installation procedure

* [Reading Pre-requisites before installation](https://linuxize.com/post/how-to-install-tomcat-9-on-ubuntu-18-04/)


```sh
$ sudo apt update -y
$ sudo useradd -r -m -U -d /opt/tomcat -s /bin/false tomcat
$ sudo apt install wget
$ echo Warning: version can change
$ wget http://www-eu.apache.org/dist/tomcat/tomcat-9/v9.0.17/bin/apache-tomcat-9.0.17.tar.gz -P /tmp
$ sudo tar xf /tmp/apache-tomcat-9*.tar.gz -C /opt/tomcat
$ sudo chmod a+x,a+r,a+w /opt
$ sudo chmod -R u+r,g+r,o+r /opt/tomcat
$ sudo chmod -R u+w,g+w,o+w /opt/tomcat
$ sudo chmod -R u+x,g+x,o+x /opt/tomcat/apache-tomcat-9.0.17/bin
$ sudo chmod -R g+x,o+x /opt/tomcat/apache-tomcat-9.0.17/conf
$ sudo chmod -R g+x,o+x /opt/tomcat/apache-tomcat-9.0.17/lib
$ sudo chmod -R g+x,o+x /opt/tomcat/apache-tomcat-9.0.17/logs
$ sudo chmod -R g+x,o+x /opt/tomcat/apache-tomcat-9.0.17/temp
$ sudo chmod -R g+x,o+x /opt/tomcat/apache-tomcat-9.0.17/webapps
$ sudo chmod -R g+x,o+x /opt/tomcat/apache-tomcat-9.0.17/work
$ sudo ln -s /opt/tomcat/apache-tomcat-9.0.17 /opt/tomcat/latest
$ sudo chown -RH tomcat:tomcat /opt/tomcat/latest
$ sudo sh -c 'chmod +x+r+w /opt/tomcat/latest/bin/*.sh'
$ sudo sh -c 'chmod +x /opt/tomcat/apache-tomcat-9.0.17/bin/*.sh'
$ sudo chmod +x /opt/tomcat/apache-tomcat-9.0.17/bin/*.sh
```

```sh
$ sudo ln -s /usr/lib/jvm/java-8-openjdk-amd64/jre /usr/lib/jvm/default-java
$ sudo vim /etc/systemd/system/tomcat.service
[Unit]
Description=Tomcat 9 servlet container
After=network.target

[Service]
Type=forking

User=tomcat
Group=tomcat

Environment="JAVA_HOME=/usr/lib/jvm/default-java"
Environment="JAVA_OPTS=-Djava.security.egd=file:///dev/urandom -Djava.awt.headless=true"

Environment="CATALINA_BASE=/opt/tomcat/latest"
Environment="CATALINA_HOME=/opt/tomcat/latest"
Environment="CATALINA_PID=/opt/tomcat/latest/temp/tomcat.pid"
Environment="CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC"

ExecStart=/opt/tomcat/latest/bin/startup.sh
ExecStop=/opt/tomcat/latest/bin/shutdown.sh

[Install]
WantedBy=multi-user.target
```

```sh
sudo systemctl daemon-reload
sudo systemctl start tomcat
sudo systemctl status tomcat
sudo systemctl stop tomcat
sudo systemctl disable tomcat
sudo ufw allow 8080/tcp
```


---
#### 3.13. Jenkins

#### a. Installation procedure

* [Reading Pre-requisites before installation](https://linuxize.com/post/how-to-install-jenkins-on-ubuntu-18-04/)

```sh
sudo apt install openjdk-8-jdk
sudo apt install wget
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt update
sudo apt install jenkins
systemctl start  jenkins
systemctl status jenkins
systemctl stop jenkins
systemctl disable jenkins
```

* Configuration Management
    * Url: http://127.0.0.1:8080/
    * Authentication: `admin/admin`

---
#### 3.14. Zabbix

#### a. Installation procedure

* [Reading Pre-requisites before installation](https://websiteforstudents.com/how-to-install-zabbix-4-0-monitoring-system-with-apache2-mariadb-and-php-7-2-on-ubuntu-16-04-18-04-18-10/)
* [Reading](https://hub.docker.com/r/zabbix/zabbix-server-pgsql)


---
#### 3.15. NMON

#### a. Installation procedure
* [Reading Pre-requisites before installation](http://nmon.sourceforge.net/pmwiki.php?n=Site.ScreenShots)

* [Step-by-Step](http://josemarfuregattideabreusilva.blogspot.com/2012/05/)

```sh
which nmon
```

---
#### 3.16. Kubernets

#### a. Installation procedure

* Reading Pre-requisites before installation:
  * [About Kubernets](https://bit.ly/ubuntu-containerd)
  * [Step-by-Step Install](https://linuxconfig.org/how-to-install-kubernetes-on-ubuntu-18-04-bionic-beaver-linux)
  * [Step-by-Step Install](https://matthewpalmer.net/kubernetes-app-developer/articles/install-kubernetes-ubuntu-tutorial.html)

```sh
sudo apt  install curl

```

---
#### 3.17. WordPress

#### a. Installation procedure
* [Reading Pre-requisites before installation](https://www.rosehosting.com/blog/how-to-install-wordpress-with-lamp-stack-on-ubuntu-18-04/)

* Step-1: Install MySQL database

```sh
$ sudo mysql
  mysql> CREATE DATABASE wordpress;
  mysql> CREATE USER 'admin_user'@'localhost' IDENTIFIED BY 'admin_user';
  mysql> GRANT ALL PRIVILEGES ON wordpress.* TO 'admin_user'@'localhost' IDENTIFIED BY 'admin_user';
  mysql> FLUSH PRIVILEGES;
  mysql> exit
```

* Step-2: Install WordPress PHP source code

```sh
$ cd /var/www/html
$ sudo wget -c http://wordpress.org/latest.zip
$ sudo apt install unzip
$ sudo unzip latest.zip
$ sudo chown -R www-data:www-data wordpress
$ sudo rm latest.zip
$ cd /var/www/html/wordpress
$ sudo mv wp-config-sample.php wp-config.php
$ sudo vim wp-config.php
  :
define('DB_NAME', 'wordpress');
define('DB_USER', 'admin_user');
define('DB_PASSWORD', 'admin_user');
  :

$ sudo vim /etc/apache2/sites-available/wordpress.com.conf
<VirtualHost *:80>

ServerAdmin admin@wordpress.com
ServerName wordpress.com
ServerAlias www.wordpress.com
DocumentRoot /var/www/html/wordpress

<Directory /var/www/html/wordpress>
     Options Indexes FollowSymLinks
     AllowOverride All
     Require all granted
</Directory>

ErrorLog ${APACHE_LOG_DIR}/wordpress.com_error.log 
CustomLog ${APACHE_LOG_DIR}/wordpress.com_access.log combined 
</VirtualHost>

$ cd /etc/apache2/sites-enabled
$ sudo ln -s ../sites-available/wordpress.com.conf wordpress.com.conf
```

* Step-3: Configure WordPress Site
  * Site Title: `WordPress`
  * Username: `admin` - Password: `admin`
  * Click install button

 
#### 3.18. Pentaho Community

#### a. Installation procedure
* Reading Pre-requisites before installation
  * [Evaluation](https://help.pentaho.com/Documentation/8.2/Setup/Evaluation)

_Working in progress_


---
#### 3.19. Hercules Mainframe Emulator

#### a. Installation procedure

* [Reading Pre-requisites - Hercules](http://www.hercules-390.eu/)


* Installing

```sh
sudo mkdir cd /opt
sudo chmod 777 /opt
cd /opt
wget http://www.hercules-390.org/hercules-3.07.tar.gz
tar -xvf hercules-3.07.tar.gz
cd hercules-3.07/
sudo ./configure
sudo make install
sudo chown ubuntu:ubuntu ./hercules-3.07 -R
which hercules
ls -la /usr/local/bin/hercules
```


#### b. Configuration management

* n/a


#### c. Deploy Diagram

* n/a

#### d. Demonstration

* n/a



---
#### 3.20. Transmission cli

#### a. Installation procedure

* [Reading Pre-requisites - Transmission / Torrent client](https://www.maketecheasier.com/how-to-download-torrents-from-the-command-line-in-ubuntu/)


* Installing

```sh
sudo apt install transmission-cli
```


#### b. Configuration management

* n/a


#### c. Deploy Diagram

* n/a

#### d. Demonstration

```sh
```


---
### 4. Docker

#### 4.1. Docker - Installation

#### a. Installation procedure

* [Reading Pre-requisites before installation](https://phoenixnap.com/kb/how-to-install-docker-on-ubuntu-18-04/)

```sh
echo remove versao anterior
sudo apt-get remove docker docker-engine docker.io -y
sudo apt install docker.io -y
sudo systemctl start  docker
sudo systemctl status docker
sudo systemctl enable docker
```

---
#### 4.2. Docker Composer - Installation

#### a. Installation procedure

* [Reading Pre-requisites before installation](https://www.digitalocean.com/community/tutorials/how-to-install-docker-compose-on-ubuntu-18-04)

```sh
$ sudo apt install curl -y
$ cd ~
$ sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
$ sudo chmod +x /usr/local/bin/docker-compose
$ docker-compose --version # docker-compose version 1.21.2, build a133471

# Edit 
$ vim docker-compose.yml
  :
my-test:
 image: hello-world
  :

# Start Docker
$ sudo systemctl start  docker.service # starting docker service ...
$ sudo docker-compose up # search for default file 'docker-compose.yml' and pull 'hello-world' image
Pulling my-test (hello-world:latest)...
latest: Pulling from library/hello-world
c04b14da8d14: Downloading [==================================================>] 
  :
my-test_1  | Hello from Docker!
my-test_1  | This message shows that your installation appears to be working correctly.
  :

$ sudo docker images # list all docker images pulled
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
hello-world         latest              fce289e99eb9        2 months ago        1.84kB
  :
ubuntu_my-test_1 exited with code 0
  :


$ sudo docker ps # list images running ...
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
  :

$ sudo docker ps -a # list all docker images independent if running or not ...
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS                          PORTS               NAMES
db160e0532ff        hello-world         "/hello"            5 minutes ago       Exited (0) About a minute ago                       hello-world_my-test_1
  :

```

#### b. Configuration management
  * n/a


---
#### 4.3. Docker Composer - MySQL 5.7 & Php MyAdmin

#### a. Installation procedure

* [Reading Pre-requisites before installation - MySQL](https://medium.com/@chrischuck35/how-to-create-a-mysql-instance-with-docker-compose-1598f3cc1bee)
* [Reading Pre-requisites before installation - MySQL e phpMyAdmin](https://share.atelie.software/subindo-um-banco-de-dados-mysql-e-phpmyadmin-com-docker-642be41f7638)

```sh
$ mkdir ~/docker-compose
$ mkdir ~/docker-compose/docker-mysql-phpmyadmin
$ cd ~/docker-compose/docker-mysql-phpmyadmin

$ vim docker-compose-mysql5.7.yml # ~/docker-mysql (only)
version: '3.3'
services:
  db:
    image: mysql:5.7
    restart: always
    environment:
      MYSQL_DATABASE: 'db'
      # So you don't have to use root, but you can if you like
      MYSQL_USER: 'user'
      # You can use whatever password you like
      MYSQL_PASSWORD: 'password'
      # Password for root access
      MYSQL_ROOT_PASSWORD: 'password'
    ports:
      # <Port exposed> : < MySQL Port running inside container>
      - '3306:3306'
    expose:
      # Opens port 3306 on the container
      - '3306'
      # Where our data will be persisted
    volumes:
      - my-db:/var/lib/mysql
# Names our volume
volumes:
  my-db:


$ vim docker-compose-mysql-phpmyadmin.yml # ~/docker-mysql, phpmyadmin
version: '3.3'
volumes:
  data:
services:
  db:
    image: mysql:5.7
    ports:
      - "3306:3306"
    volumes:
      - data:/var/lib/mysql
    environment:
      - MYSQL_ROOT_USER=user
      - MYSQL_ROOT_PASSWORD=password
      - MYSQL_DATABASE=app_development
  app:
    image: phpmyadmin/phpmyadmin:latest
    links:
      - db
    ports:
      - 80:80
    environment:
      - PMA_ARBITRARY=1

$ 

$ pwd # /home/ubuntu/docker-compose/docker-mysql-phpmyadmin
$ sudo docker-compose -f docker-compose-mysql5.7.yml up         # subindo imagem apenas com MySQL
$ sudo docker-compose -f docker-compose-mysql-phpmyadmin.yml up # subindo imagem MySQL + PhpMyAdmin
```

#### b. Configuration management

* docker-compose-mysql5.7.yml:
  * MySQL - port: 3306; user: user; password: password; volume: my-db
* docker-compose-mysql-phpmyadmin:
  * MySQL - port: 3306; user: user; password: password; volume: my-db
  * phpMyAdmin - port: 80/81; servidor db; user: user; password: password

#### c. Deploy Diagram

![DeployDiagram - Context - DockerCompose - MySQL phpMyAdmin](doc/images/DeployDiagram%20-%20Context%20-%20DockerCompose%20-%20MySQL%20phpMyAdmin.png)


#### d. Demonstration

  * Subindo **docker-compose** com arquivo de configuração `docker-compose-mysql-phpmyadmin.yml`:

```sh
$ sudo docker-compose -f docker-compose-mysql-phpmyadmin.yml up         # subindo imagem apenas com MySQL
```


  * Conectando com MySQL através do client em linha de comando `mysql`:

```sh
$ mysql -h 127.0.0.1 -u user -ppassword
  :
mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| db                 |
+--------------------+
  :
```

  * Conectando com MySQL através da aplicação web **phpMyAdmin**:

![Demo - ](doc/images/PrintScreen-Demo-DockerCompose-MySQLphpMyAdmin.png)


---
#### 4.4. Docker Composer - PostgreSQL 9.6, pgAdmin4

#### a. Installation procedure

* [Reading Pre-requisites before installation - Official Documentation](https://linuxhint.com/run_postgresql_docker_compose/)
* [Reading Pre-requisites before installation - Blog using Docker Composer](https://medium.com/@renato.groffe/postgresql-pgadmin-4-docker-compose-montando-rapidamente-um-ambiente-para-uso-55a2ab230b89)
* [Reading Pre-requisites before installation - Stack Overflow about docker composer volume](https://stackoverflow.com/questions/41637505/how-to-persist-data-in-a-dockerized-postgres-database-using-volumes/41650891)
* [Reading Pre-requisites before installation - Stack Overflow about docker composer volume](https://stackoverflow.com/questions/42107364/how-to-use-volume-in-docker-compose-for-postgres)
* [Reading Pre-requisites before installation - pgAdmin4](https://hub.docker.com/r/dpage/pgadmin4/)

```sh
$ mkdir ~/docker-compose
$ mkdir ~/docker-compose/docker-postgresql-pgadmin4
$ cd    ~/docker-compose/docker-postgresql-pgadmin4

$ vim docker-compose-postgresql-pgadmin4.yml
version: '3'
volumes:
  pg-data:

services:
  db:
    image: postgres
    volumes:
      - pg-data:/var/lib/postgresql/data
    ports:
      - 5432:5432

  pgadmin:
    image: dpage/pgadmin4
    environment:
      PGADMIN_DEFAULT_EMAIL: "josemarsilva@yahoo.com.br"
      PGADMIN_DEFAULT_PASSWORD: "password"
    ports:
      - "16543:80"
    depends_on:
      - db

$ pwd # /home/ubuntu/docker-compose/docker-postgresql-pgadmin4
$ sudo docker-compose up

```

#### b. Configuration management

* docker-compose.yml:
  * PostgreSQL - port: 5432; user: postgres; password: ; volume: db
  * pgAdmin4 - port: 16543; email: josemarsilva@yahoo.com.br; password: password

#### c. Deploy Diagram

![DeployDiagram - Context - DockerCompose - PostgreSQL](doc/images/DeployDiagram%20-%20Context%20-%20DockerCompose%20-%20PostgreSQL%20pgAdmin4.png)


#### d. Demonstration

  * Subindo **docker-compose** com arquivo de configuração default `docker-compose.yml`:

```sh
$ sudo docker-compose up         # subindo imagem apenas com PostgreSQL
```


  * Conectando com PostgreSQL através do client em linha de comando `pgsql`:

```sh
$ sudo su - postgres
postgres@ubuntu-server:~$ psql -h 127.0.0.1 -U postgres
  :
postgres=# \l
                                 List of databases
   Name    |  Owner   | Encoding |  Collate   |   Ctype    |
-----------+----------+----------+------------+------------+
 postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 |
 template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 |
 template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 |
           |          |          |            |            |
  :
postgres=# create database test_db;
postgres=# create user pguser with encrypted password 'password';
postgres=# grant all privileges on database test_db to pguser;
postgres=# \q
```

  * Conectando com PostgreSQL através da aplicação webapp **pgAdmin4**:

![Demo - pgAdmin4](doc/images/PrintScreen-Demo-DockerCompose-PostgreSQLpgAdmin4-01.png)

```txt
url.....: http://localhost:16543
login...: josemarsilva@yahoo.com.br
password: password
```

![Demo - pgAdmin4](doc/images/PrintScreen-Demo-DockerCompose-PostgreSQLpgAdmin4-02.png)



---
#### 4.5. Docker Composer - NPX HTTP Server (simple http server)

#### a. Installation procedure

* [Reading Pre-requisites before installation](https://share.atelie.software/subindo-um-servidor-web-em-1-minuto-31c0438ff6dd)

```sh
$ mkdir ~/docker-compose
$ mkdir ~/docker-compose/docker-npx-httpserver
$ cd    ~/docker-compose/docker-npx-httpserver

$ vim docker-compose.yml
version: '3'
services:
  web:
    image: node
    working_dir: /web
    command: npx http-server
    volumes:
      - .:/web
    ports:
      - 8080:8080

$ pwd # /home/ubuntu/docker-compose/docker-npx-httpserver
$ sudo docker-compose up
```

#### b. Configuration management

* docker-compose.yml:
  * NPX HTTP Server - port: 8080

#### c. Deploy Diagram

n/a

#### d. Demonstration

  * Suba **docker-compose** com arquivo de configuração default `docker-compose.yml`:
  * Faça wget http://localhost:8080


---
#### 3.16.4. Docker Composer - WordPress, MySQL 5.7

#### a. Installation procedure

* [Reading Pre-requisites before installation](https://docs.docker.com/compose/wordpress/)

```sh
$ mkdir ~/docker-compose/docker-wordpress-mysql
$ cd    ~/docker-compose/docker-wordpress-mysql
$ vim docker-compose.yml
version: '3.3'

services:
   db:
     image: mysql:5.7
     ports:
       - "3306:3306"
     volumes:
       - db_data:/var/lib/mysql
     restart: always
     environment:
       MYSQL_ROOT_PASSWORD: password
       MYSQL_DATABASE: wordpress
       MYSQL_USER: wordpress
       MYSQL_PASSWORD: wordpress

   wordpress:
     depends_on:
       - db
     image: wordpress:latest
     ports:
       - "80:80"
     restart: always
     environment:
       WORDPRESS_DB_HOST: db:3306
       WORDPRESS_DB_USER: wordpress
       WORDPRESS_DB_PASSWORD: wordpress
       WORDPRESS_DB_NAME: wordpress
volumes:
    db_data: {}

$ sudo docker-compose up
$ sudo docker-compose down  # parar o serviço
```


#### b. Configuration management

* docker-compose.yml:
  * WordPress - port: 80; Username: wordpress
  * MySQL - port: 3306; user: wordpress; password: wordpress; volume: db_data

#### c. Deploy Diagram

n/a

#### d. Demonstration

  * Suba **docker-compose** com arquivo de configuração default `docker-compose.yml`:
  * Abra a URL `http://localhost:80` e siga o passo-a-passo da instalação:

* Passo 1: Defina a linguagem:

![Demo - WordPress - passo 1](doc/images/PrintScreen-Demo-DockerCompose-WordPress-01.png)

* Passo 2: Defina título do site, usuário e senha
![Demo - WordPress - passo 1](doc/images/PrintScreen-Demo-DockerCompose-WordPress-02.png)

* Passo 3: Clique no botão que acesso o site:

![Demo - WordPress - passo 1](doc/images/PrintScreen-Demo-DockerCompose-WordPress-03.png)

* Passo 4: Informe `login` e `senha` e acesse o site

![Demo - WordPress - passo 1](doc/images/PrintScreen-Demo-DockerCompose-WordPress-04.png)

* Passo 5: Acesse a página principal do site 

![Demo - WordPress - passo 1](doc/images/PrintScreen-Demo-DockerCompose-WordPress-05.png)


---
#### 4.6. Docker Composer - Oracle Database

#### a. Installation procedure

* [Reading Pre-requisites before installation - OracleDatabase on Docker - Single Instance](https://github.com/oracle/docker-images/blob/master/OracleDatabase/SingleInstance/README.md)
* [Reading Pre-requisites before installation - OracleDatabase - Single Instance](https://www.oracle.com/technetwork/pt/articles/database-performance/oracle-db12-2-no-docker-4427706-ptb.html)

```sh
$ mkdir ~/GitHome
$ cd    ~/GitHome
$ git clone https://github.com/oracle/docker-images.git
$ git clone https://github.com/MaksymBilenko/docker-oracle-12c.git
$ cd docker-oracle-12c
$ cd ~/GitHome/docker-images/OracleDatabase/SingleInstance/dockerfiles
$ ./buildDockerImage.sh 12.2.0.1 -s
$ docker run --name oracle-12-2 \
-p 1521:1521 -p 5500:5500 \
-e ORACLE_SID=ORCL \
-e ORACLE_PDB=ORCLPDB \
-e ORACLE_PWD=password \
-e ORACLE_CHARACTERSET=AMERICAN_AMERICA.AL32UTF8 \
-v oradata:/opt/oracle/oradata \
oracle/database:12.2.0-se

$ vim docker-compose.yml


$ pwd # /home/ubuntu/docker-compose/docker-oracle
$ sudo docker-compose up
```

#### b. Configuration management

* docker-compose.yml:
  * Oracle Database - port: 1521; user: ???; password:??? ; volume: db

#### c. Deploy Diagram

![DeployDiagram - Context - DockerCompose - Oracle](doc/images/DeployDiagram%20-%20Context%20-%20DockerCompose%20-%20Oracle.png)


#### d. Demonstration

  * Subindo **docker-compose** com arquivo de configuração default `docker-compose.yml`:


---
#### 4.7. Docker - Jenkins

#### a. Installation procedure

* [Reading Pre-requisites](https://hub.docker.com/r/bitnami/jenkins/)

* Using Docker Command Line


```sh
$ echo *** Part I - Configuration files ....
$ mkdir ~/docker-cmdline
$ mkdir ~/docker-cmdline/docker-jenkins
$ cd ~/docker-cmdline/docker-jenkins

$ echo *** Part II - Network Tier ....
$ sudo docker network ls # create only once - first time you create, next times reuses
$ sudo docker network create jenkins-tier

$ echo *** Part III - Data Volume
$ sudo docker volume ls # create only once - first time you create, next times reuses
$ sudo docker volume create --name jenkins_data # Only once - first time you create, next times reuses

$ echo *** Part IV - Run Docker 
$ sudo docker ps -a
$ sudo docker rm jenkins
$ sudo docker run -d --name jenkins -p 8080:8080 -p 443:8443 \
  --net jenkins-tier \
  --volume jenkins_data:/bitnami \
  bitnami/jenkins:latest

```


#### b. Configuration management

* Jenkins URL: `http://localhost:8080/
* Environment variables:
  * JENKINS_USERNAME: `user`
  * JENKINS_PASSWORD: `bitnami`


#### c. Deploy Diagram

![DeployDiagram - Context - DockerCompose - Jenkins](doc/images/DeployDiagram%20-%20Context%20-%20DockerCompose%20-%20Jenkins.png)


#### d. Demonstration

  * Subindo **docker-compose** com arquivo de configuração `docker-compose-jenkins.yml`:

```sh
$ sudo docker-compose -f docker-compose-jenkins.yml up
```


  * Conectando com MySQL através do client em linha de comando `mysql`:

```sh
$ 
```

  * Conectando com MySQL através da aplicação web **phpMyAdmin**:

![Demo - Docker Jenkins](doc/images/PrintScreen-Demo-DockerCompose-Jenkins.png)

---
#### 4.8. Docker Composer - MongoDB

#### a. Installation procedure

* [Reading Pre-requisites](https://hub.docker.com/r/bitnami/mongodb/)

* Using Docker Compose

```sh
$ echo *** Part I - Configuration files ....
$ mkdir ~/docker-compose
$ mkdir ~/docker-compose/docker-mongodb/
$ cd ~/docker-compose/docker-mongodb

$ echo *** Part II - Configuring docker-compose.yml ...
$ vim docker-compose-mongodb.yml
version: '2'

services:
  mongodb:
    image: 'bitnami/mongodb:4.0'
    ports:
      - "27017:27017"
    volumes:
      - 'mongodb_data:/bitnami'

volumes:
  mongodb_data:
    driver: local
  :

$
$ sudo docker-compose -f docker-compose-mongodb.yml up -d
```


#### b. Configuration management

* n/a



#### c. Deploy Diagram

![DeployDiagram - Context - DockerCompose - Jenkins](doc/images/DeployDiagram%20-%20Context%20-%20DockerCompose%20-%20MongoDB.png)


#### d. Demonstration

  * Subindo **docker-compose** com arquivo de configuração `docker-compose-mongodb.yml`:

```sh
$ sudo docker-compose -f docker-compose-mongodb.yml up -d
```

  * Conectando ao MongoDB:

```sh
$ mongo --eval 'db.runCommand({ connectionStatus: 1 })'
```


---
#### 4.9. Docker Composer - Redmine

#### a. Installation procedure

* [Reading Pre-requisites](https://hub.docker.com/_/redmine)

* Using Docker Compose:

```sh
$ echo *** Part I - Configuration files ....
$ mkdir ~/docker-compose
$ mkdir ~/docker-compose/docker-redmine/
$ cd ~/docker-compose/docker-redmine

$ echo *** Part II - Configuring docker-compose.yml ...
$ vim docker-compose-redmine.yml
version: '3.1'

services:

  redmine:
    image: redmine
    restart: always
    ports:
      - 8080:3000
    environment:
      REDMINE_DB_MYSQL: db
      REDMINE_DB_PASSWORD: example

  db:
    image: mysql:5.7
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: example
      MYSQL_DATABASE: redmine
  :

$
$ sudo docker-compose -f docker-compose-redmine.yml up   -d
$ sudo docker-compose -f docker-compose-redmine.yml down -d
```

* Using Docker Command Line:


#### b. Configuration management

* url: `http://localhost:8080/
* username: `admin`
* password: `admin123` (inicialmente configurada `admin`)



#### c. Deploy Diagram

![DeployDiagram - Context - DockerCompose - Redmine](doc/images/DeployDiagram%20-%20Context%20-%20DockerCompose%20-%20Redmine.png)


#### d. Demonstration

  * Subindo **docker-compose** com arquivo de configuração `docker-compose-redmine.yml`:

```sh
$ sudo docker-compose -f docker-compose-redmine.yml up -d
```

  * Conectando ao Redmine `http://localhost:8080/` :
    * Login: `admin`
	* Password: `admin123`

---
#### 4.10. Docker Composer - Kafka

#### a. Installation procedure

* [Reading Pre-requisites](https://hub.docker.com/r/bitnami/kafka/)
* [Reading Tutorial](https://medium.com/trainingcenter/apache-kafka-codifica%C3%A7%C3%A3o-na-pratica-9c6a4142a08f)

* Using Docker Compose:

```sh
$ echo *** Part I - Configuration files ....
$ mkdir ~/docker-compose
$ mkdir ~/docker-compose/docker-kafka/
$ cd ~/docker-compose/docker-kafka

$ echo *** Part II - Configuring docker-compose.yml ...
$ vim docker-compose-kafka.yml
version: '2'

services:
  zookeeper:
    image: 'bitnami/zookeeper:latest'
    ports:
      - '2181:2181'
    volumes:
      - 'zookeeper_data:/bitnami/zookeeper'
  kafka:
    image: 'bitnami/kafka:0'
    ports:
      - '9092:9092'
    volumes:
      - 'kafka_data:/bitnami/kafka'
    environment:
      - KAFKA_ZOOKEEPER_CONNECT=zookeeper:2181

volumes:
  zookeeper_data:
    driver: local
  kafka_data:
    driver: local
  :

$
$ sudo docker-compose -f docker-compose-kafka.yml up -d
$ sudo docker-compose -f docker-compose-kafka.yml down
```

#### b. Configuration management

* zookeeper: Port=2181
* kafka: Port=9092, 


#### c. Deploy Diagram

![DeployDiagram - Context - DockerCompose - Kafka](doc/images/DeployDiagram%20-%20Context%20-%20DockerCompose%20-%20Kafka.png)


#### d. Demonstration

  * Subindo **docker-compose** com arquivo de configuração `docker-compose-Kafka.yml`:

```sh
$ sudo docker-compose -f docker-compose-Kafka.yml up -d
```

  * Conectando ao Kafka `http://localhost:8080/` :
    * Login: `admin`
	* Password: `admin123`

---
#### 4.11. Docker Composer - Cassandra

#### a. Installation procedure

* [Reading Pre-requisites](https://hub.docker.com/r/bitnami/cassandra/)

* Using Docker Composer:

```sh
$ mkdir ~/docker-compose
$ mkdir ~/docker-compose/docker-cassandra
$ cd    ~/docker-compose/docker-cassandra

$ vim docker-compose-cassandra.yml
version: '2'

services:
  cassandra:
    image: 'bitnami/cassandra:3'
    ports:
      - '7000:7000'
      - '9042:9042'
    volumes:
      - 'cassandra_data:/bitnami'
    environment:
      - CASSANDRA_SEEDS=cassandra
      - CASSANDRA_PASSWORD_SEEDER=yes
      - CASSANDRA_PASSWORD=cassandra
volumes:
  cassandra_data:
    driver: local

  :

$
$ sudo docker-compose -f docker-compose-cassandra.yml up   -d
$ sudo docker-compose -f docker-compose-cassandra.yml down -d
```


#### b. Configuration management

* cassandra seeds...: `cassandra`
* cassandra password: `cassandra`
* ports.............: `7000` e `9042`


#### c. Deploy Diagram

![DeployDiagram - Context - DockerCompose - Cassandra](doc/images/DeployDiagram%20-%20Context%20-%20DockerCompose%20-%20Cassandra.png)


#### d. Demonstration

  * Subindo **docker-compose** com arquivo de configuração `docker-compose-cassandra.yml`:

```sh
$ sudo docker-compose -f docker-compose-cassandra.yml up   -d
$ sudo docker-compose -f docker-compose-cassandra.yml down -d
```

  * Conectando ao Cassandra `http://localhost:8080/` :


---
#### 4.12. Docker Composer - MQ-Series

#### a. Installation procedure

* [Reading Pre-requisites](https://hub.docker.com/r/ibmcom/mq/)
* [Reading Pre-requisites - Building a sample IBM MQ queue manager image using Docker](https://www.ibm.com/support/knowledgecenter/en/SSFKSJ_9.0.0/com.ibm.mq.con.doc/q114483_.htm)
* [Reading Pre-requisites - Building a sample base IBM MQ queue manager image](https://www.ibm.com/support/knowledgecenter/en/SSFKSJ_9.0.0/com.ibm.mq.con.doc/q114485_.htm)

* Using Docker Dockerfile:

* Step 1: Create network

```sh
mkdir mq-series
git clone -b mq-9-lts https://github.com/ibm-messaging/mq-docker mq-docker
git clone https://github.com/ibm-messaging/mq-container mq-container
ip addr show

```


#### b. Configuration management

* url: `http://localhost:8080/


#### c. Deploy Diagram

![DeployDiagram - Context - DockerCompose - MQ-Series](doc/images/DeployDiagram%20-%20Context%20-%20DockerCompose%20-%20MQ-Series.png)


#### d. Demonstration

  * Subindo **docker-compose** com arquivo de configuração `docker-compose-MQ-Series.yml`:

```sh
$ sudo docker-compose -f docker-compose-MQ-Series.yml up -d
```

  * Conectando ao MQ-Series `????` :


---
#### 4.13. Docker Composer - SugarCRM

#### a. Installation procedure

* [Reading Pre-requisites](https://hub.docker.com/r/spantree/sugarcrm)

* Using Docker Composer:

```sh
$ mkdir ~/docker-compose
$ mkdir ~/docker-compose/docker-sugarcrm
$ cd    ~/docker-compose/docker-sugarcrm

$ vim docker-compose-sugarcrm.yml
sugarcrm:
  build: .
  ports:
    - "8000:80"
  links:
    - "db"
  environment:
    DB_TYPE: mysql
    DB_MANAGER: MysqlManager
db:
  image: mysql
  environment:
    MYSQL_ROOT_PASSWORD: YZiT4p7BXUqpdgpc
    MYSQL_DATABASE: sugarcrm
    MYSQL_USER: sugarcrm
    MYSQL_PASSWORD: wTxbULZMrosNR86J
  :

$
$ sudo docker-compose -f docker-compose-sugarcrm.yml up
```


#### b. Configuration management

* url: http://127.0.0.1:8000/


#### c. Deploy Diagram

![DeployDiagram - Context - DockerCompose - Cassandra](doc/images/DeployDiagram%20-%20Context%20-%20DockerCompose%20-%20SugarCrm.png)


#### d. Demonstration

  * Subindo **docker-compose** com arquivo de configuração `docker-compose-cassandra.yml`:

```sh
$ sudo docker-compose -f docker-compose-sugarcrm.yml up
```

  * Conectando ao Cassandra `http://localhost:8080/` :

---
#### 4.14. Docker - Bamboo Server

#### a. Installation procedure

* [Reading Pre-requisites](https://hub.docker.com/r/atlassian/bamboo-server)

* Using Docker Composer:

```sh
$ mkdir ~/docker-cmdline
$ mkdir ~/docker-cmdline/docker-bamboo-server
$ cd    ~/docker-cmdline/docker-bamboo-server

$ docker pull atlassian/bamboo-server

$ sudo docker volume create --name bambooVolume
$ sudo docker run -v bambooVolume:/var/atlassian/application-data/bamboo --name="bamboo" --init -d -p 54663:54663 -p 8085:8085 atlassian/bamboo-server
```


#### b. Configuration management

* url: http://127.0.0.1:8000/


#### c. Deploy Diagram

![DeployDiagram - Context - DockerCompose - Cassandra](doc/images/DeployDiagram%20-%20Context%20-%20DockerCompose%20-%20SugarCrm.png)


#### d. Demonstration

  * Subindo **docker-compose** com arquivo de configuração `docker-compose-cassandra.yml`:

```sh
$ sudo docker-compose -f docker-compose-sugarcrm.yml up
```

  * Conectando ao Cassandra `http://localhost:8080/` :

---
#### 4.15. Docker - Ubuntu server

#### a. Installation procedure

* [Reading Pre-requisites](https://www.youtube.com/watch?v=0cDj7citEjE&t=682s)


* Using Docker Command Line:

```sh
sudo docker run -i -t ubuntu:18.04 /bin/bash
```


#### b. Configuration management

* n/a


#### c. Deploy Diagram

* n/a

#### d. Demonstration

* n/a

---
#### 4.16. Docker - Chef-server

#### a. Installation procedure

* [Reading Pre-requisites](https://hub.docker.com/r/cbuisson/chef-server/)


* Using Docker Command Line:

```sh
docker pull cbuisson/chef-server
```


#### b. Configuration management

* n/a


#### c. Deploy Diagram

* n/a

#### d. Demonstration

* n/a

