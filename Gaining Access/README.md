# Tips on getting quicker exploits
<img width="1024" height="1024" alt="Husky hacker working on gaining access" src="https://github.com/user-attachments/assets/9f5501d4-d238-49b2-9645-df182edc9207" />

## With Searchsploit
```
nmap -sC -sV -p- --open -v --min-rate 5000 -oN scan.nmap $target
```
```
cat scan.nmap | grep open
```

```
searchsploit $(cat scan.nmap | grep open | awk '{print $3}')`
```
```
grep open scan.nmap | awk '{print $3}' | xargs searchsploit
```

## Recon Script
```
chmod +x recon.sh
./recon.sh 10.10.10.10
```
## Tools
https://www.revshells.com/#bind --> Gains shells and payloads

https://www.exploit-db.com/ --> everything you probably need, I go with the repo vs the other
```
sudo apt update && sudo apt install exploitdb
```
It may need an update from time to time

With nmap too:

Examples
```
grep Exploits /usr/share/nmap/scripts/*.nse
nmap --script-help=clamav-exec.nse 
```


## Link on CTF enumeration and tips 
https://medium.com/@aaronashley466/oscp-ctf-tips-and-tricks-835e7c2ab96a
