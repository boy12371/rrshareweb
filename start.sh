#!/bin/bash
#
yum -y update
yum install make wget crontabs -y
mkdir -p /data/download
mkdir /data/app
mkdir /data/movies
mv rrshareweb_centos6_64.tar.gz /data/download
cd /data/app
tar -zxvf ../download/rrshareweb_centos6_64.tar.gz
cat >/etc/systemd/system/renren.service <<EOF
[Unit]
Description=RenRen server
After=network.target
Wants=network.target
[Service]
Type=simple
PIDFile=/var/run/renren.pid
ExecStart=/data/app/rrshareweb/rrshareweb
RestartPreventExitStatus=23
Restart=always
User=root

[Install]
WantedBy=multi-user.target
EOF
systemctl status renren.service
systemctl start renren.service
systemctl enable renren.service
