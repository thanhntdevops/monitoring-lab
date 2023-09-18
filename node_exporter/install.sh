#!/bin/bash

if [[ ! -n $VERSION ]];then
    export VERSION=1.6.1
fi
wget https://github.com/prometheus/node_exporter/releases/download/v$VERSION/node_exporter-$VERSION.linux-amd64.tar.gz
tar xvfz node_exporter-*.*-amd64.tar.gz
cd node_exporter-*.*-amd64
mv node_exporter /usr/local/bin/
# read -p "username : " username
# read -sp "password : " password
# cat <<EOF > hashpw.py
# import getpass
# import bcrypt
# import sys

# username = sys.argv[1]
# password = sys.argv[2]
# hashed_password = bcrypt.hashpw(password.encode("utf-8"), bcrypt.gensalt())
# print(username +": "+ hashed_password.decode())
# EOF
# apt-get update && apt-get install python3-pip -y && pip3 install bcrypt
# basic_auth=`python3 hashpw.py $username $password`

if [[ -n $BASIC_AUTH ]];then
    mkdir -p /etc/node_exporter
cat << EOF > /etc/node_exporter/web-config.yml
basic_auth_users:
  $BASIC_AUTH
EOF
    NODE_EXPORTER_ARGS="--web.config.file=/etc/node_exporter/web-config.yml"
fi

cat << EOF > /etc/systemd/system/node_exporter.service
[Unit]
Description=Node Exporter
After=network.target

[Service]
User=nobody
Group=nogroup
Type=simple
ExecStart=/usr/local/bin/node_exporter $NODE_EXPORTER_ARGS
Restart=always

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable node_exporter
systemctl start node_exporter
cd ../ && rm -rf node_exporter-*
echo "installation has been successfully completed"
