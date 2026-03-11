@echo off
:CHECK_CONNECTIVITY
ping -n 1 www.google.com >nul
if %errorlevel% neq 0 (
echo Internet connection lost!
rem Add actions to be taken when the connection is lost
) else (
echo Internet connection is active.
)
timeout /t 10 >nul
goto CHECK_CONNECTIVITY
