# eval-virtualbox-vm - Evaluation Virtual Box VM

---
## 1. Introduction

Evaluation Virtual Box VM is a guide project to install, configure and manage a lot of stuff into a Ubuntu 18.04 VM in Virtual Box.

---
## 2. Configuration Managment

### 2.1. Authentication Credentials
* ubuntu/ubuntu

---
#### 2.2. Network Configurations
* Host -> Guest (127.0.0.1)
* Port(s): Apache2/NGINX(80,81,443), OpenSSH(22), Jenkins/Tomcat/microk8s(8080,8081), JupyterNotebook(8888), PostgreSQL(5432), MySQL(3306), Casandra(7000,7199,9042,9160), MongoDB(27017,27018,27019)

---
### 3. Installed Softwares and Packages

#### 3.1. NodeJs

```sh
sudo apt install npm
npm -b # 3.5.2
```

---
#### 3.2. MongoDB

```sh
sudo apt install -y mongodb 
sudo systemctl start  mongodb
sudo systemctl status mongodb
mongo --eval 'db.runCommand({ connectionStatus: 1 })'
```

---
#### 3.3. Java 8 JDK

```sh
sudo apt install openjdk-8-jdk -y
```

---
#### 3.4. Python 2.7

```sh
sudo apt update
sudo apt install python -y
```

---
#### 3.5. Casandra

* [Pre-requisites before instalation](http://cassandra.apache.org/download/) 

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
#### 3.6. PostgreSQL

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
#### 3.7. MySQL

````sh
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
#### 3.8. Jenkins

* [Pre-requisites before installation](https://linuxize.com/post/how-to-install-jenkins-on-ubuntu-18-04/)

```sh
sudo apt install jenkins
systemctl start  jenkins
systemctl status jenkins
```

* Configuration Management
    * Url: http://127.0.0.1:8080/
    * Authentication: admin/admin

---
#### 3.9. Jenkins

* [Pre-conditions](http://wiki.ubuntu-br.org/UFW)

```sh
sudo systemctl start  ufw
sudo systemctl status ufw
sudo systemctl enable ufw
```

---
#### 3.10. Apache2

* [Pre-conditions](https://www.digitalocean.com/community/tutorials/how-to-install-the-apache-web-server-on-ubuntu-18-04-quickstart)

```sh
sudo apt-get install apache2
sudo systemctl start apache2
sudo systemctl status apache2
```

---
#### 3.11. NGINX

* [Pre-conditions](https://www.digitalocean.com/community/tutorials/como-instalar-o-nginx-no-ubuntu-18-04-pt)

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

* [Step-by-Step](https://linuxize.com/post/how-to-install-tomcat-9-on-ubuntu-18-04/)


---
#### 3.13. Docker

* [Pre-conditions](https://phoenixnap.com/kb/how-to-install-docker-on-ubuntu-18-04/)

```sh
sudo apt-get remove docker docker-engine docker.io
sudo apt install docker.io
sudo systemctl start  docker
sudo systemctl status docker
sudo systemctl enable docker
```

---
#### 3.14. Apache Kafka

* [Step-by-Step](https://www.digitalocean.com/community/tutorials/how-to-install-apache-kafka-on-ubuntu-18-04/)
* Configuration Management
    * Authentication Credentials: kafka/kafka


---
#### 3.15. Zabbix
* [Step-by-Step](https://websiteforstudents.com/how-to-install-zabbix-4-0-monitoring-system-with-apache2-mariadb-and-php-7-2-on-ubuntu-16-04-18-04-18-10/)

---
#### 3.16. Kubernets
* [Pre-conditions](https://linuxconfig.org/how-to-install-kubernetes-on-ubuntu-18-04-bionic-beaver-linux)

```sh
sudo snap install microk8s --channel=1.14/beta --classic
sudo snap start   microk8s
sudo snap stop    microk8s
sudo snap disable microk8s
```

---
#### 3.17. NMON
* [Pre-conditions](http://nmon.sourceforge.net/pmwiki.php?n=Site.ScreenShots)
* [Step-by-Step](http://josemarfuregattideabreusilva.blogspot.com/2012/05/)

```sh
which nmon
```

---
#### 3.18. UFW

```sh
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
```

---
#### 3.19. Jupyter Notebook

* [Reading Pre-requisites](https://www.digitalocean.com/community/tutorials/como-configurar-o-jupyter-notebook-com-python-3-no-ubuntu-18-04-pt)

* Step-by-step:

```sh
# Install Python, Pip3 e VirtualEnv ...
sudo apt update
sudo apt install python3-pip python3-dev
sudo -H pip3 install --upgrade pip
sudo -H pip3 install virtualenv
# O flag -H garante politica de seguranca configure a variavel home para o diretório do usuário
cd ~/GitHome
mkdir ~/GitHome/py-jupyter-env
cd    ~/GitHome/py-jupyter-env
virtualenv py-jupyter-env # criando o ambiente virtual chamado 'py-jupyter-env'
source py-jupyter-env/bin/activate

# Install Jupyter no ambiente criado pelo virtualenv
pip install jupyter

# Starting Jupyter Notebook
jupyter notebook
```

