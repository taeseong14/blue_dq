@echo off
setlocal EnableDelayedExpansion

if not exist ip.txt (
    set /p ip="ip: "
    echo !ip! > ip.txt
) else (
    set /p ip=<ip.txt
    set ip=!ip: =!
)

echo ip: %ip% (del ip.txt to change)

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

set screenX=2340
set screenY=1080

echo opening app

set t=10 & call :wait

@REM TODO: 한번만 출력하도록 바꿔야함.
echo.
echo [93m[^^!] Warning[0m 
echo [93m[^^!] Check if program clicks EXACT CENTER of the screen[0m 
echo [93m[^^!] if not^^: edit .cmd #42, 43[0m 
echo.

set t=5 & call :wait
set /a x = screenX / 2
set /a y = screenY / 2


set /a i=0
:loop
echo clicking... check the screen
adb shell input tap %x% %y%
set t=1 & call :wait
set /a i=%i%+1
if %i% LEQ 5 goto loop

timeout /t 20 /nobreak

adb shell input tap 100 1000 REM 오늘 하루 보지 않기
set t=1 & call :wait
adb shell input tap %x% %y% REM touch to start
echo game started

@REM TODO: ./READMD.md#47
@REM timeout /t 30 /nobreak

@REM adb shell input tap 2090 90 REM 공지 x




:End
set /p a="Enter to continue"
goto eof


:wait
timeout /t !t! /nobreak > nul 2>&1
goto eof

:screencap
adb shell screencap sdcard/screen.png
adb pull sdcard/screen.png b_a/screen.png
goto eof


@REM DEBUG; escape: 