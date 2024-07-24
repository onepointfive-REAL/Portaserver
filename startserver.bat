@echo off
rem one liner starter
start /d "%cd%\htdocs" "pyserver" "%cd%\server\python.exe" -m http.server 80