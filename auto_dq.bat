@echo off
setlocal EnableDelayedExpansion

@REM if not exist ip.txt (
@REM     set /p ip="ip: "
@REM     echo !ip! > ip.txt
@REM ) else (
@REM     set /p ip=<ip.txt
@REM     set ip=!ip: =!
@REM )

@REM echo ip: %ip% (del ip.txt to change)

cd ..

adb start-server

:ConnectDevice
for /f "tokens=*" %%a in ('adb devices ^| findstr /R /C:"device$" ^| find /C /V ""') do set devices=%%a
echo connected devices: %devices%

if !devices! LSS 1 (
    set t=2 & call :wait
    goto ConnectDevice
) else if !devices! GTR 1 ( REM using more than 1 device
    echo [^^!] connected device more than 1
    adb disconnect
    echo "enter port of device to connect"
    set /p port="port: "
    adb connect !ip!:!port!
)


adb shell input keyevent KEYCODE_HOME
adb shell monkey -p com.nexon.bluearchive -c android.intent.category.LAUNCHER 1 > nul 2>&1
adb shell monkey -p com.nexon.bluearchiveteen -c android.intent.category.LAUNCHER 1 > nul 2>&1

echo opening app

set t=5  & call :wait

for /f "tokens=3" %%a in ('adb shell wm size') do (
    for /f "tokens=1,2 delims=x" %%b in ("%%a") do (
        set screenX=%%c
        set screenY=%%b
    )
)
echo screen size: %screenX%x%screenY%
@REM 내껀 2340x1080



set /a x = screenX / 2
set /a y = screenY / 2


timeout /t 20 /nobreak REM TODO: 딜레이 다시 조정

adb shell input tap 100 1000 REM 오늘 하루 보지 않기
set t=1 & call :wait
adb shell input tap %x% %y% REM touch to start
echo game started

@REM TODO: ./READMD.md#47
@REM timeout /t 30 /nobreak

@REM adb shell input tap 2090 90 REM 공지 x




:End
set /p a="Enter to continue"
goto :eof


:wait
timeout /t !t! /nobreak > nul 2>&1
goto :eof

:screencap
adb shell screencap sdcard/screen.png
adb pull sdcard/screen.png b_a/screen.png > nul 2>&1
adb shell rm sdcard/screen.png
goto :eof


@REM DEBUG; escape: 
