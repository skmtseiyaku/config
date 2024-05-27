#!/bin/bash
#archlinux
#configure ip first
SCRIPT=$(readlink -f "$0")
BASEDIR=$(dirname "$SCRIPT")
mkdir $HOME/.local/bin


sudo yay -S samba avahi wsdd
sudo touch /etc/samba/smb.conf
echo | sudo tee /etc/samba/smb.conf

#cp $BASEDIR/smb.conf /etc/samba/smb.conf
sudo systemctl enable smb nmb wsdd
echo "Creating a new user..."
echo echo -n "Share name: "
read SHARENAME
echo -n "Username: "
read USERNAME

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
public = yes
browseable = yes
writable = yes
guest ok = no
workgroup = WORKGROUP
deadtime = 60
max connections = 0
create mask = 0775
directory mask = 0775
admin users = $USERNAME
EOT

useradd $USERNAME
passwd $USERNAME
pdbedit –a $USERNAME #新建Samba账户。 
#pdbedit –x username：删除Samba账户。 
#pdbedit –L：列出Samba用户列表，读取passdb.tdb数据库文件。 
#pdbedit –Lv：列出Samba用户列表的详细信息。 
#pdbedit –c “[D]” –u username：暂停该Samba用户的账号。 
#pdbedit –c “[]” –u username：恢复该Samba用户的账号。
