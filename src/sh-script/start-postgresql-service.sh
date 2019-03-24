#/bin/sh
sudo systemctl start  postgresql.service
sudo systemctl status postgresql.service
echo
echo Next steps:
echo '$ sudo -u postgres psql -c "SELECT version();"'
echo '$ sudo su - postgres'
echo '$ psql'
echo '  postgres=# \l postgres'
echo 
