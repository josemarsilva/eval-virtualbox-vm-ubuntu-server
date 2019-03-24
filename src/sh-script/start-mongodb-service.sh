#/bin/sh
sudo systemctl start  mongodb.service
sudo systemctl status mongodb.service
echo
echo Next steps:
echo   mongo --eval 'db.runCommand({ connectionStatus: 1 })'
echo
