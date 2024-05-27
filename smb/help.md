# SMB Configuration
```
passdb backend = tdbsam
```

该方式则是使用一个数据库文件来建立用户数据库。数据库文件叫passdb.tdb，默认在```/etc/samba```目录下。

passdb.tdb用户数据库可以使用```smbpasswd –a```来建立Samba用户，不过要建立的Samba用户必须先是系统用户。

我们也可以使用```pdbedit```命令来建立Samba账户。

```pdbedit```命令的参数很多，我们列出几个主要的。 

```
pdbedit –a username #新建Samba账户。 
pdbedit –x username #删除Samba账户。 
pdbedit –L #列出Samba用户列表，读取passdb.tdb数据库文件。 
pdbedit –Lv #列出Samba用户列表的详细信息。 
pdbedit –c "[D]" –u username #暂停该Samba用户的账号。 
pdbedit –c "[]" –u username #恢复该Samba用户的账号。
```


# References
https://handerfly.github.io/运维/2019/08/29/samba/

https://www.samba.org/samba/docs/current/man-html/smb.conf.5.html