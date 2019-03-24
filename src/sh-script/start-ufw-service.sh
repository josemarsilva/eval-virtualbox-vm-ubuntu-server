#/bin/sh
sudo systemctl start  ufw.service
sudo systemctl status ufw.service
echo
echo Next steps:
echo ' sudo ufw status verbose'
echo ' sudo ufw app list'
echo ' sudo ufw allow 80/tcp    # Apache2, NGINX'
echo 
