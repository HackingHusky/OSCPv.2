## PIMP MY KALI

This repo has you covered. Now, do you need everything in this repo? Probably not, but a quick Impacket-based reinstall script makes all the difference. 
```
sudo apt update && sudo apt upgrade
```
```
sudo shutdown -r now
```
```
git clone https://github.com/Dewalt-arch/pimpmykali
cd pimpmykali
chmod +x ./pimpmykali
sudo ./pimpmykali
```
If you have a fresh image, use option zero. Not really needed for the oscp but handy. 

## Setting up Burp Suite
Make sure Burp is running

Make sure to get FoxyProxy

In Firefox, go to:

http://burp

Download CA Certificate

Then install it:

Firefox →
Settings → Privacy & Security → Certificates → View Certificates → Import

Import the Burp certificate and trust it.

Then test it:
Proxy → Intercept → Intercept ON

Then:

Set Firefox proxy → 127.0.0.1:8080

Install Burp CA cert

Turn Intercept ON

## Tools

### Terminator is a great tool 
https://github.com/spabinger/terminator-cheat-sheet

```
sudo apt update
sudo apt install terminator
```

### rlwrap
```
sudo apt install rlwrap -y
```

Really have this tool handy with netcat and shell on Windows. Use case:
```
rlwrap nc -lvnp <port>
```

### Dirbuster
This is my main tool for web enumeration since it has a default list
```
sudo apt install dirbuster -y
```
Use case:
```
dirsearch -u http://$target
```

## Other quick links you can use
https://www.kali.org/tools/evil-winrm-py/ --> python evil-winrm, works the same as evil-winrm

https://www.kali.org/tools/unicornscan/ --> great network scan

https://www.kali.org/tools/freerdp3/ --> RDP

Hack Tools extension:

<img width="1695" height="736" alt="image" src="https://github.com/user-attachments/assets/4868512b-af9b-4558-bbff-a7538b55cf91" />

FoxyProxy:

<img width="1519" height="735" alt="image" src="https://github.com/user-attachments/assets/91ccf4f2-c441-4e31-98ac-5c69fbda3222" />

Wappyalyzer:

<img width="1238" height="623" alt="image" src="https://github.com/user-attachments/assets/05c60c85-b046-4708-b3a1-ef59d3825039" />


https://github.com/swisskyrepo/PayloadsAllTheThings --> refer to this repo

https://www.kali.org/tools/seclists/ --> install seclists

Wine, you'll need it in some cases
```
sudo apt install wine
```
