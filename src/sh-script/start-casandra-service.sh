#/bin/sh
sudo systemctl start  cassandra.service
sudo systemctl status cassandra.service
echo
echo Next steps:
echo  \$ cqlsh 
echo    cqsql\> SELECT cluster_name, listen_address FROM system.local;
echo 
