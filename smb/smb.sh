#!/bin/bash
#archlinux
#configure ip first
SCRIPT=$(readlink -f "$0")
BASEDIR=$(dirname "$SCRIPT")

sudo yay -S samba avahi wsdd
sudo touch /etc/samba/smb.conf
echo | sudo tee /etc/samba/smb.conf

#cp $BASEDIR/smb.conf /etc/samba/smb.conf
sudo systemctl enable smb nmb wsdd

echo -n "Share name: "
read SHARENAME

echo -n "Size (MB): "
read SIZE

echo -n "Create a new user (y/N): "
read INPUT
case $INPUT in
    y|yes)
        echo -n "Username: "
        read USERNAME
        sudo useradd $USERNAME
        sudo passwd $USERNAME
        sudo pdbedit –a $USERNAME
esac

echo -n "Admin username: "
read ADMINUSER

mkdir $HOME/smb/$SHARENAME

sudo tee -a /etc/samba/smb.conf > /dev/null <<EOT
[global]
server string = FileExchange
netbios name = FileExchange
server smb encrypt = desired
security = user
passdb backend = tdbsam
guest account = nobody
load printers = no
printing = bsd
printcap name = /dev/null
disable spoolss = yes
show add printer wizard = no

[FileExchange]
path = $HOME/smb/$SHARENAME
max disk size = $SIZE
public = yes
browseable = yes
writable = yes
guest ok = no
workgroup = WORKGROUP
deadtime = 60
max connections = 0
create mask = 0775
directory mask = 0775
admin users = $ADMINUSER
EOT

