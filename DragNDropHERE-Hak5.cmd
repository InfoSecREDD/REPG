@echo off
SET "DIR=%~dp0"
PUSHD "%DIR%"
cd /D "%DIR%"
powershell.exe -noexit -file %DIR%/encode.ps1 %*