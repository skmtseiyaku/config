#!/bin/bash
#archlinux
#configure ip first
SCRIPT=$(readlink -f "$0")
BASEDIR=$(dirname "$SCRIPT")

yay -S samba avahi wsdd
sudo touch /etc/samba/smb.conf
echo | sudo tee /etc/samba/smb.conf

#cp $BASEDIR/smb.conf /etc/samba/smb.conf
sudo systemctl enable smb nmb wsdd

SERVERNAME=$(uname -n)

echo -n "Share name: "
read SHARENAME

echo -n "Size (MB): "
read SIZE

echo -n "Create a new user (y/N): "
read INPUT
case $INPUT in
    y|yes)
        echo -n "Username: "
        while read USERNAME; do
            sudo useradd $USERNAME
            sudo passwd $USERNAME
            sudo pdbedit -a "$USERNAME"
            break
        done

esac

echo -n "Admin username: "
read ADMINUSER
#while read ADMINUSER; do
#    sudo pdbedit -a "$ADMINUSER"
#    break
#done 

mkdir $HOME/smb
mkdir $HOME/smb/$SHARENAME

sudo tee -a /etc/samba/smb.conf > /dev/null <<EOT
[global]
server string = $SERVERNAME
netbios name = $SERVERNAME
server smb encrypt = desired
security = user
passdb backend = tdbsam
guest account = nobody
load printers = no
printing = bsd
printcap name = /dev/null
disable spoolss = yes
show add printer wizard = no

[$SHARENAME]
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

exit
