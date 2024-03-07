#!/bin/bash
sudo su
# Prompt the user for the hostname
read -p "Enter the hostname for your email server: " hostname
hostnamectl set-hostname $hostname
# Prompt the host file entry
read -p "Enter the host Entry for your email server:(example: 192.168.1.152   mail.sampleserver.xyz      mail): " hosts
echo "$hosts" > /etc/hosts
sudo systemctl restart systemd-hostnamed
sudo systemctl restart networking
#Update The Repo
apt update -y
apt upgrade -y
sudo apt install -y curl lsb-release
apt install postgresql-12
read -s -p "Insert Password:" DB_ADM_PWD
su - postgres -c "psql --command=\"CREATE ROLE carbonio_adm WITH LOGIN SUPERUSER encrypted password '$DB_ADM_PWD';\""
su - postgres -c "psql --command=\"CREATE DATABASE carbonio_adm owner carbonio_adm;\""
unset DB_ADM_PWD
#    Download the following script using
wget https://repo.zextras.io/inst_repo_ubuntu.sh
#Execute the script (remember to give it the execution rights)
chmod +x inst_repo_ubuntu.sh
./inst_repo_ubuntu.sh
apt update && apt upgrade -y
read -p "enter your email server ip: " ip
echo "$ip" | service-discover setup-wizard
pending-setups -a
apt install carbonio-ce -y
carbonio-bootstrap
read -p "ente same --zextras@computingforgeeks.com-- :" zextras
su - zextras
zmprov setpassword $zextras 1234567
# Access Zimbra Administration Console
echo "Open your web browser and navigate to https://$hostname:6071"
echo "Log in with the admin credentials you created."
# Configure DNS Records
echo "Configure the necessary DNS records for your domain, including MX, SPF, DKIM, and DMARC records."
# Test Email Delivery
echo "Send a test email to verify that your server is correctly configured."


echo "  !!!!!!!!!!!!!!!!!!!!!!! Congratulations We did a great Job !!!!!!!!!!!!!!!!!!!!!!!!!!!1"




