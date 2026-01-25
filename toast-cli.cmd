@echo off
setlocal

set "ps_script_name=toast-cli.ps1"

powershell %~dp0%ps_script_name% %*

exit /b %ERRORLEVEL%

