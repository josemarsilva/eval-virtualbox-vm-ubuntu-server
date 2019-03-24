#/bin/sh
sudo systemctl start  jenkins.service
sudo systemctl status jenkins.service
echo
echo Next steps:
echo '  http://localhost:8080/'
echo '    admin/admin'
echo
