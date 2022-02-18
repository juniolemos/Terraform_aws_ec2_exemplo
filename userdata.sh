#!/bin/bash
apt-get update 
apt-get install zabbix-agent -y 
sed -i  "s/Server=127.0.0.1/ Server=172.31.24.129/"  /etc/zabbix/zabbix_agentd.conf
sed -i  "s/ServerActive=127.0.0.1/ ServerActive=172.31.24.129/"  /etc/zabbix/zabbix_agentd.conf      
sed -i  "s/#Hostname=/ Hostname= teste-ec2/"  /etc/zabbix/zabbix_agentd.conf   
mkfs -t ext4 /dev/nvme1n1
mkdir  /aplicacoes
mount -t ext4 /dev/nvme1n1 /aplicacoes
echo /dev/nvme1n1 /aplicacoes ext4  defaults 0 0 >> /etc/fstab