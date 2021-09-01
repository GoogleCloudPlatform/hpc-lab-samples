#!/bin/bash

yum -y install nfs-utils

systemctl start nfs-server rpcbind
systemctl enable nfs-server rpcbind

mkdir -p "/home"
mkdir -p "/tools"

chmod 777 "/home" "/tools"

echo '/home/ *(rw,sync,no_root_squash)' >> "/etc/exports"
echo '/tools/ *(rw,sync,no_root_squash)' >> "/etc/exports"

exportfs -r