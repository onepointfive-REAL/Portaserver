@echo off
set old=%cd%
echo Starting...
change.exe "%cd%\conf\httpd.conf" "*FINDLOC*" "%cd%" > nul
IF "%errorlevel%"=="1" (goto working) ELSE goto broken
:broken
echo  ************************************************************
echo  *  Portaserver V2 status: Fixing conf (due to early exit)  *
echo  ************************************************************
echo                   (DO NOT CLOSE THIS WINDOW)
rem Exuse me for the goofy ahh code below
set /p LAST_KNOWN= < "%cd%\vars\last_known_loc.var" > nul 2> nul
rem Bye goofy ahh code
change.exe "%cd%\conf\httpd.conf" "%LAST_KNOWN%" "%cd%" > nul
IF "%errorlevel%"=="1" (goto working) ELSE goto broken1
:broken1
cls
@del "%cd%\vars\last_known_loc.var" > nul 2> nul
color 47
echo !!! %cd%\conf\httpd.conf is damaged. !!!
echo To fix this change "Define SRVROOT "*location*"" to "Define SRVROOT "*FINDLOC*""
echo.
echo Reasons (from minor to major):
echo 1. It could be the current release (probably will be fixed in the next release)
echo 2. It could be that you messed up your httpd.conf file
echo 3. It could be that your install is corrupted
echo.
echo Press any key to exit...
pause > nul
goto exit
:working
echo %cd% > "%cd%\vars\last_known_loc.var"
cd bin
cls
echo  ************************************
echo  *  Portaserver V2 status: Running  *
echo  ************************************
echo.
if exist "%old%\htdocs\index.html" (goto indexexist) else goto indexnotexist
:indexexist
echo  *******************************
echo  *  index.html status: Exists  *
echo  *******************************
goto rest
:indexnotexist
echo  ***************************************
echo  *  index.html status: Does not Exist  *
echo  ***************************************
goto rest
:rest
echo Do not close this window, Instead press any key
start /min "Apache (server)" httpd
echo Press any key to stop Apache...
@pause > nul 2> nul
@taskkill /t /f /im httpd.exe > nul 2> nul
cls
echo  ************************************
echo  *  Portaserver V2 status: Exiting  *
echo  ************************************
echo       (DO NOT CLOSE THIS WINDOW)
cd..
@change.exe "%cd%\conf\httpd.conf" "%cd%" "*FINDLOC*" > nul 2> nul
@timeout /nobreak /t 3 > nul 2> nul
:exit
exit

