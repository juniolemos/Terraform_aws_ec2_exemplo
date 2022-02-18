#!/bin/bash
apt-get update 
#install zabbix e configuração do .conf
apt-get install zabbix-agent -y 
sed -i  "s/Server=127.0.0.1/ Server=SEUIPAQUI/"  /etc/zabbix/zabbix_agentd.conf
sed -i  "s/ServerActive=127.0.0.1/ ServerActive=SEUIPAQUI/"  /etc/zabbix/zabbix_agentd.conf      
sed -i  "s/#Hostname=/ Hostname= teste-app/"  /etc/zabbix/zabbix_agentd.conf   
#Montar os discos
mkfs -t ext4 /dev/nvme1n1
mkdir  /aplicacoes
mount -t ext4 /dev/nvme1n1 /aplicacoes
echo /dev/nvme1n1 /aplicacoes ext4  defaults 0 0 >> /etc/fstab