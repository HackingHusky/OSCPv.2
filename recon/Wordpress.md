# Wordpress
<img width="1024" height="1024" alt="Husky hacker hacking wordpress" src="https://github.com/user-attachments/assets/99be5e08-f950-4106-978f-a8299dd5b6b8" />

## Enumerate like normal

```
nmap -sV -sC -p 80,443 <target_ip>
gobuster dir -u http://<ip>/ -w /usr/share/seclists/Discovery/Web-Content/common.txt
```
Once found, use this:
```
wpscan --url http://<target_url> --enumerate vp,vt,u
wpscan --url http://<target_url> --enumerate p --plugins-detection aggressive
ffuf -u http://<ip>/wp-content/plugins/FUZZ -w wp-plugins.txt
```
If the user found, try this:
```
wpscan --url <URL> -U admin -P /usr/share/wordlists/rockyou.txt
```
