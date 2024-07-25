@echo off 
set og=%cd%
echo Running on a flash drive will be slow. (notice)
echo Building portaserver v2..
echo (prebuild binarys will be availible later)
md php
md vars
tar -xf apache.zip
cd php
tar -xf "%og%/pt1.zip"
tar -xf "%og%/pt2.zip"
cd..
cd conf
del httpd.conf
copy "%og%\httpd.conf" "%cd%\httpd.conf"
pause
echo Complete. Check if it works

