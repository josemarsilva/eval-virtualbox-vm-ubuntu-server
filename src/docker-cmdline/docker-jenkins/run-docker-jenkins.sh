# /bin/sh

sudo docker network ls | grep jenkins
sudo docker volume ls  | grep jenkins
sudo sudo docker ps -a | grep jenkins

export OLD_CONTAINER=`sudo docker ps -a | grep jenkins | cut -d' ' -f 1`
sudo docker rm $OLD_CONTAINER

sudo docker run -d --name jenkins -p 8080:8080 -p 443:8443 \
  --net jenkins-tier \
  --volume jenkins_data:/bitnami \
  bitnami/jenkins:latest
