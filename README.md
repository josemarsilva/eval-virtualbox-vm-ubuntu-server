# eval-virtualbox-vm - Evaluation Virtual Box VM

---
## 1. Introduction

Evaluation Virtual Box VM is a guide project to install, configure and manage a lot of stuff into a Ubuntu 18.04 VM in Virtual Box.

### 1.1. Deploy Diagram

![DeployDiagram - Context - EvalVirtualboxVmUbuntuServer](doc/images/DeployDiagram%20-%20Context%20-%20EvalVirtualboxVmUbuntuServer.png)


---
## 2. Configuration Managment

### 2.1. Authentication Credentials
* ubuntu/ubuntu

---
#### 2.2. Network Configurations
* Host -> Guest (127.0.0.1)
* Port(s): Apache2/NGINX(80,81,443), OpenSSH(22), Jenkins/Tomcat/microk8s(8080,8081), JupyterNotebook(8888), PostgreSQL(5432), MySQL(3306), Casandra(7000,7199,9042,9160), MongoDB(27017,27018,27019)
* [Passo a passo da configuração da rede do Virtual Box](doc/README_NetworkConfiguration_StepByStep.md)

---
### 3. Installed Softwares and Packages

#### 3.1. NodeJs

#### a. Installation procedure

```sh
sudo apt install npm
npm -b # 3.5.2
```

---
#### 3.2. Java 8 JDK

#### a. Installation procedure

```sh
sudo apt install openjdk-8-jdk -y
```

---
#### 3.3. Python 2.7

#### a. Installation procedure

* Step-by-Step installation Python

```sh
sudo apt update
sudo apt install python -y
```

* Step-by-Step installation Numpy

```sh
sudo pip3 install numpy
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
sudo ufw allow 'Nginx HTTP'
sudo ufw allow 'Nginx HTTPS'
sudo ufw allow 'Nginx Full'
sudo ufw allow 'Apache Full'
sudo ufw allow 'OpenSSH'
sudo ufw allow 80/tcp    # Apache2, NGINX
sudo ufw allow 8080/tcp  # Jenkins/Tomcat/microk8s
sudo ufw allow 3306/tcp  # MySQL
sudo ufw allow 5432/tcp  # PostgreSQL
sudo ufw allow 8888/tcp  # JupyterNotebook
sudo ufw allow 27017/tcp # MongoDB mongod/mongos
sudo ufw allow 27018/tcp # MongoDB shardsrv
sudo ufw allow 27019/tcp # MongoDB configsrv
sudo ufw allow 18083/tcp # VBoxWebService

```

---
#### 3.5. PHP 7.3

#### a. Installation procedure

* [Reading Pre-requisites before installation](https://www.rosehosting.com/blog/how-to-install-php-7-3-on-ubuntu-18-04/)

```sh
$ sudo apt update
$ sudo apt upgrade
$ sudo apt install software-properties-common
$ sudo apt install python-software-properties
$ sudo add-apt-repository ppa:ondrej/php
  :
  Press [ENTER] to continue or Ctrl-c to cancel adding it. [ENTER]
  :
$ sudo apt update
$ sudo apt-cache search php7.3
$ sudo apt install php7.3 php7.3-cli php7.3-common php7.3-opcache php7.3-curl php7.3-mbstring php7.3-mysql php7.3-zip php7.3-xml
$ php -v  # Verificar a versao 7.3
$ php --ini | grep "Loaded Configuration File"
$ sudo vim /etc/php/7.3/cli/php.ini
$ sudo vim /var/www/html/phpinfo.php
<?php phpinfo(); ?>
$ sudo systemctl stop   apache2
$ sudo systemctl start  apache2
$ sudo systemctl status apache2

# Open url
http://IP-ADDRESS/phpinfo.php
```

---
#### 3.6. MySQL 

#### a. Installation procedure

```sh
sudo apt install mysql-server
sudo mysql_secure_installation
systemctl start  mysql.service
systemctl status mysql.service
sudo mysql
mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sys                |
| zabbix             |
+--------------------+
6 rows in set (0.27 sec)
```

* Configuration Management
    * Port: 3306, User: 'ubuntu'@'%', Password: ubuntu
    * Port: 3306, User: 'zabbixuser'@'localhost,' Password: 'zabbixuser'


---
#### 3.7. PostgreSQL

#### a. Installation procedure

```sh
sudo apt install postgresql postgresql-contrib
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
```

---
#### 3.8. MongoDB

#### a. Installation procedure

```sh
sudo apt install -y mongodb 
sudo systemctl start  mongodb
sudo systemctl status mongodb
mongo --eval 'db.runCommand({ connectionStatus: 1 })'
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
sudo apt-get install cassandra
sudo systemctl start  cassandra
sudo systemctl status cassandra
nodetool status
cqlsh 
  cqsql> SELECT cluster_name, listen_address FROM system.local;
```

---
#### 3.10. Apache2

#### a. Installation procedure

* [Reading Pre-requisites before installation](https://www.digitalocean.com/community/tutorials/how-to-install-the-apache-web-server-on-ubuntu-18-04-quickstart)

```sh
revisar pois faltou
sudo apt-get   install apache2
sudo systemctl start   apache2
sudo systemctl status  apache2
```

---
#### 3.11. NGINX

#### a. Installation procedure

* [Reading Pre-requisites before installation](https://www.digitalocean.com/community/tutorials/como-instalar-o-nginx-no-ubuntu-18-04-pt)

```sh
sudo apt install nginx
sudo ufw app list
sudo ufw allow 'Nginx HTTP'
sudo ufw status
sudo systemctl status nginx
sudo systemctl start nginx
```

---
#### 3.12. Tomcat

#### a. Installation procedure

* [Reading Pre-requisites before installation](https://linuxize.com/post/how-to-install-tomcat-9-on-ubuntu-18-04/)


---
#### 3.13. Jenkins

#### a. Installation procedure

* [Reading Pre-requisites before installation](https://linuxize.com/post/how-to-install-jenkins-on-ubuntu-18-04/)

```sh
sudo apt install jenkins
systemctl start  jenkins
systemctl status jenkins
```

* Configuration Management
    * Url: http://127.0.0.1:8080/
    * Authentication: admin/admin

---
#### 3.14. Jupyter Notebook

#### a. Installation procedure
* [Reading Pre-requisites before installation](https://www.digitalocean.com/community/tutorials/como-configurar-o-jupyter-notebook-com-python-3-no-ubuntu-18-04-pt)

* Step-by-step:

```sh
# Install Python, Pip3 e VirtualEnv ...
$ sudo apt update
$ sudo apt install python3-pip python3-dev
$ sudo -H pip3 install --upgrade pip
$ sudo -H pip3 install virtualenv

# O flag -H garante politica de seguranca configure a variavel home para o diretório do usuário
$ cd ~/GitHome
$ mkdir ~/GitHome/py-jupyter-env
$ cd    ~/GitHome/py-jupyter-env
$ virtualenv py-jupyter-env # criando o ambiente virtual chamado 'py-jupyter-env'
$ source py-jupyter-env/bin/activate

# Install Jupyter no ambiente criado pelo virtualenv
$ pip install jupyter

# Generating Jupyter Notebook configuration file
$ jupyter notebook --generate-config

# Enabling 
$ vim /home/ubuntu/.jupyter/jupyter_notebook_config.py
  :
c.NotebookApp.allow_origin = '*' #allow all origins
c.NotebookApp.ip = '0.0.0.0' # listen on all IPs
  :


# Starting Jupyter Notebook
jupyter notebook
```

---
#### 3.15. Docker

#### a. Installation procedure

* [Reading Pre-requisites before installation](https://phoenixnap.com/kb/how-to-install-docker-on-ubuntu-18-04/)

```sh
sudo apt-get remove docker docker-engine docker.io
sudo apt install docker.io
sudo systemctl start  docker
sudo systemctl status docker
sudo systemctl enable docker
```

---
#### 3.16. Docker Composer - hello-world

#### a. Installation procedure

* [Reading Pre-requisites before installation](https://www.digitalocean.com/community/tutorials/how-to-install-docker-compose-on-ubuntu-18-04)

```sh
$ sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
$ sudo chmod +x /usr/local/bin/docker-compose
$ docker-compose --version # docker-compose version 1.21.2, build a133471
$ mkdir hello-world
$ cd hello-world
$ docker-compose.yml
my-test:
 image: hello-world
$ sudo systemctl start  docker.service # starting docker service ...
$ sudo docker-compose up # search for default file 'docker-compose.yml' and pull 'hello-world' image
Pulling my-test (hello-world:latest)...
latest: Pulling from library/hello-world
c04b14da8d14: Downloading [==================================================>] 
$ sudo docker images # list all docker images pulled
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
hello-world         latest              fce289e99eb9        2 months ago        1.84kB
$ docker ps # list images running ...
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
$ docker ps -a # list all docker images independent if running or not ...
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS                          PORTS               NAMES
db160e0532ff        hello-world         "/hello"            5 minutes ago       Exited (0) About a minute ago                       hello-world_my-test_1
$ 
```

#### b. Configuration management
  * n/a


---
#### 3.17. Docker Composer - MySQL 5.7 & Php MyAdmin

#### a. Installation procedure

* [Reading Pre-requisites before installation](https://share.atelie.software/subindo-um-banco-de-dados-mysql-e-phpmyadmin-com-docker-642be41f7638)
* [Reading Pre-requisites before installation](https://medium.com/@chrischuck35/how-to-create-a-mysql-instance-with-docker-compose-1598f3cc1bee)

```sh
$ mkdir ~/docker-compose
$ mkdir ~/docker-compose/docker-mysql
$ cd ~/docker-compose/docker-mysql
$ vim docker-compose.yml # ~/docker-mysql
  :
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
	  :
$ pwd # /home/ubuntu/docker-mysql
$ sudo docker-compose up # search for default file 'docker-compose.yml' and pull 'mysql' image
```

#### b. Configuration management
  * n/a

#### c. Deploy Diagram

![DeployDiagram - Context - EvalVirtualboxVmUbuntuServer](doc/images/DeployDiagram%20-%20Context%20-%20DockerCompose%20-%20MySQL%20phpMyAdmin.png)


---
#### 3.18. Zabbix

#### a. Installation procedure

* [Reading Pre-requisites before installation](https://websiteforstudents.com/how-to-install-zabbix-4-0-monitoring-system-with-apache2-mariadb-and-php-7-2-on-ubuntu-16-04-18-04-18-10/)


---
#### 3.19. NMON

#### a. Installation procedure
* [Reading Pre-requisites before installation](http://nmon.sourceforge.net/pmwiki.php?n=Site.ScreenShots)

* [Step-by-Step](http://josemarfuregattideabreusilva.blogspot.com/2012/05/)

```sh
which nmon
```

---
#### 3.20. Kubernets

#### a. Installation procedure

* Reading Pre-requisites before installation:
  * [About Kubernets](https://bit.ly/ubuntu-containerd)
  * [Step-by-Step](https://linuxconfig.org/how-to-install-kubernetes-on-ubuntu-18-04-bionic-beaver-linux)

```sh
sudo apt  install curl
sudo snap install microk8s --channel=1.14/beta --classic
sudo snap start   microk8s
sudo snap stop    microk8s
sudo snap disable microk8s
```

---
#### 3.21. WordPress

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

 
#### 3.22. Pentaho Community

#### a. Installation procedure
* Reading Pre-requisites before installation
  * [Evaluation](https://help.pentaho.com/Documentation/8.2/Setup/Evaluation)

_Working in progress_
