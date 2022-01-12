#!/bin/sh
echo "========================================================="
echo "=       Updating OS                                     ="
echo "========================================================="
apt-get update
apt-get upgrade -y
echo "========================================================="
echo "=       Creating New Username                           ="
echo "========================================================="
echo "Input new Username:"
read new_username
adduser $new_username
usermod -aG sudo $new_username
echo "========================================================="
echo "=       Locking ROOT user for ssh login                 ="
echo "========================================================="
sed -i '/PermitRootLogin yes/c\PermitRootLogin no' "/etc/ssh/sshd_config"
echo "========================================================="
echo "=      Change Default SSH Port to new One               ="
echo "========================================================="
echo "Input new port number for SSH:"
read new_port
sed -i '/#Port 22/c\Port $new_port' "/etc/ssh/sshd_config"
echo "========================================================="
echo "=      Restarting SSH                                   ="
echo "========================================================="
service ssh restart
echo "========================================================="
echo "=      Adding New Port to Firewall                      ="
echo "========================================================="
ufw allow $new_port
ufw enable
echo "========================================================="
echo "=     Disabling root user                               ="
echo "========================================================="
passwd -l root
