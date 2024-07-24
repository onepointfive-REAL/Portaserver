@echo off
rem #Portaserver starter script
echo Starting...

rem #Conf
set htdocs=%cd%\htdocs
set title=portaserver
set python=%cd%\server\python.exe
set port=80
set module=http.server

rem #Start
start /d "%htdocs%" "%title%" "%python%" -m %module% %port%
exit