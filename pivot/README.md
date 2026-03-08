# Pivoting

## Installs 

### Follow this link:
https://www.kali.org/tools/ligolo-ng/ --> Better option

https://www.kali.org/tools/chisel/ --> Still good to have just incase

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



## Portfowarding SSH 

```
ssh -L LOCALPORT:TARGET:PORT user@pivot
ssh -D 1080 user@pivot
proxychains nmap TARGET
```
