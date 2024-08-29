@echo off
setlocal enabledelayedexpansion

echo starting adb server...
..\adb start-server

if not exist ip.txt (
    set /p ip="ip: "
    echo !ip! > ip.txt
    echo [^^!] ip.txt created
) else (
    set /p ip=<ip.txt
    set ip=!ip: =!
)

cd ..

set /p port="port: "
adb pair "%ip%:%port%"

pause
