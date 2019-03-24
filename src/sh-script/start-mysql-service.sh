#/bin/sh
sudo systemctl start mysql.service
sudo systemctl status mysql.service
echo
echo 'Next steps:'
echo '  1. Local VM'
echo '     $ sudo mysql'
echo '     mysql> show databases;'
echo '  2. Host'
echo '     C:\> mysql -h localhost -u ubuntu -pubuntu'
