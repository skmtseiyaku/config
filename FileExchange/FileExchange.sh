#archlinux
#configure ip first
pacman -S git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
yay -S samba avahi wsdd
cp ~/smb/smb.conf /etc/samba/smb.conf
systemctl enable smb nmb wsdd
useradd file
passwd file
pdbedit –a file #新建Samba账户。 
#pdbedit –x username：删除Samba账户。 
#pdbedit –L：列出Samba用户列表，读取passdb.tdb数据库文件。 
#pdbedit –Lv：列出Samba用户列表的详细信息。 
#pdbedit –c “[D]” –u username：暂停该Samba用户的账号。 
#pdbedit –c “[]” –u username：恢复该Samba用户的账号。
