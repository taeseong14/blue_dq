@echo off
setlocal EnableDelayedExpansion

if not exist settings.txt (
    echo _SYSTEM__BRIGHTNESS_DOWN=0>settings.txt
    echo _SYSTEM__SOUND_DOWN=0>>settings.txt
    echo AP_BUY=0>>settings.txt
    echo SHOP__NORMAL_BUY=1>>settings.txt
    echo SHOP__NORMAL_REFRESH=0>>settings.txt
    echo SHOP__TACTCHAL_ON=0>>settings.txt
    echo SHOP__TACTCHAL_BUY=5,6>>settings.txt
    echo SHOP__TACTCHAL_REFRESH=0>>settings.txt
    echo TASK__A_USE=1>>settings.txt
    echo TASK__A_PICK=0>>settings.txt
    echo TASK__B_USE=1>>settings.txt
    echo TASK__B_PICK=0>>settings.txt
    echo TASK__TACTCHAL_TRY=1>>settings.txt
    echo TASK__TACTCHAL_PICK=3>>settings.txt
    echo TASK__TACTCHAL_CLIAM_REWARD=0>>settings.txt
    echo TASK__HARD_ON=0>>settings.txt
    echo TASK__HARD_STAGE=15-2>>settings.txt
)

for /f "delims=" %%a in (settings.txt) do (
    for /f "tokens=1,2 delims==" %%b in ("%%a") do (
        set S_%%b=%%c
    )
)

cd ..
adb start-server

:ConnectDevice
for /f "tokens=*" %%a in ('adb devices ^| findstr /R /C:"device$" ^| find /C /V ""') do set devices=%%a
echo connected devices: %devices%

if !devices! LSS 1 (
    node b_a/js/w.js 2
    goto ConnectDevice
) else if !devices! GTR 1 (
    echo [^^!] connected device more than 1
    adb disconnect
    echo "enter ip and port of device to connect"
    set /p ip="ip: "
    set /p port="port: "
    adb connect !ip!:!port!
)

for /f "tokens=3 delims==" %%a in ('adb shell dumpsys window ^| findstr "mDreamingLockscreen="') do set device_locked=%%a
if %device_locked% == true (
    echo.
    echo [93m[^^!] device is locked[0m
    if exist on.bat ( call on & echo. ) else goto End
)


adb shell input keyevent KEYCODE_HOME
adb shell monkey -p com.nexon.bluearchive -c android.intent.category.LAUNCHER 1 > nul 2>&1
adb shell monkey -p com.nexon.bluearchiveteen -c android.intent.category.LAUNCHER 1 > nul 2>&1

echo opening app

node b_a/js/w.js 5

for /f "tokens=3" %%a in ('adb shell wm size') do (
    for /f "tokens=1,2 delims=x" %%b in ("%%a") do (
        set screenX=%%c
        set screenY=%%b
    )
)
echo screen size: %screenX%x%screenY%



set /a x = screenX / 2
set /a y = screenY / 2


@REM wait for game to load
:loop
call :screencap
node b_a/js/getPixelRGB.js 193 963
for /f "tokens=*" %%a in (b_a\result.txt) do (
    if "%%a" == "243 244 244" (
        echo ready
        del b_a\screen.png b_a\result.txt
    ) else goto :loop
)

for /l %%a in (1, 1, 6) do (
    adb shell input tap 369 1017
    node b_a/js/w.js 200
)
adb shell input tap %x% %y%
echo game started

node b_a/js/w.js 30 1

adb shell input tap %x% %y% 

node b_a/js/w.js 3500 1

adb shell input tap %x% %y%
echo memorial skipping
node b_a/js/w.js 700
adb shell input tap 1380 777

node b_a/js/w.js 6 1
adb shell input tap 2077 86
echo notice closed

node b_a/js/w.js 3 1

adb shell input tap 1900 133
node b_a/js/w.js 500
adb shell input tap 1900 133
echo claim monthly reward
node b_a/js/w.js 2 1
adb shell input tap 1900 133
echo closing things
for /l %%a in (1, 1, 4) do (
    node b_a/js/w.js 500
    adb shell input tap 1900 133
)
node b_a/js/w.js 3

adb shell input tap 241 974
echo opening cafe
node b_a/js/w.js 9 1

adb shell input tap 2000 500 
node b_a/js/w.js 1

@REM @REM TODO: 카페 학생 탭하기

adb shell input tap 2024 959
echo cafe ap
node b_a/js/w.js 1
adb shell input tap 1170 824
echo claim ap
node b_a/js/w.js 3
for /l %%a in (1, 1, 3) do (
    adb shell input tap 1900 133
    node b_a/js/w.js 500
)
adb shell input tap 286 166
node b_a/js/w.js 1
adb shell input tap 500 272
echo goto cafe 2
node b_a/js/w.js 9 1
adb shell input tap 2000 500

node b_a/js/w.js 1
@REM TODO: 카페 학생 탭하기 (2호점)

adb shell input tap 2185 41
node b_a/js/w.js 12 1

@REM adb shell input tap 432 974 @REM TODO: 스케쥴

adb shell input tap 1023 974
echo social button
node b_a/js/w.js 1500
adb shell input tap 500 500
node b_a/js/w.js 4
adb shell input tap 2185 41
node b_a/js/w.js 200
adb shell input tap 2185 41
node b_a/js/w.js 4

adb shell input tap 1239 974
echo jejo
node b_a/js/w.js 2
adb shell input tap 2000 983
echo claim all
node b_a/js/w.js 4
adb shell input tap 1900 133
node b_a/js/w.js 500
adb shell input tap 1592 983
echo quick make
node b_a/js/w.js 2
adb shell input tap 1968 930
node b_a/js/w.js 1
adb shell input tap 1380 777
node b_a/js/w.js 1
adb shell input tap 2185 41
node b_a/js/w.js 3

adb shell input tap 1435 974
echo shop
node b_a/js/w.js 4
adb shell input tap 1275 408
adb shell input tap 2066 980
echo buy selected
node b_a/js/w.js 300
adb shell input tap 1387 753
node b_a/js/w.js 2
adb shell input keyevent KEYCODE_BACK 
node b_a/js/w.js 100
adb shell input keyevent KEYCODE_BACK
node b_a/js/w.js 4

adb shell input tap 2122 827
echo task
node b_a/js/w.js 5 1

adb shell input tap 1352 655
echo task a
node b_a/js/w.js 3
set /a r = %random% %% 3
echo random: %r%
if %r% == 0 (
    adb shell input tap 2000 345
) else if %r% == 1 (
    adb shell input tap 2000 536
) else (
    adb shell input tap 2000 707
)
node b_a/js/w.js 2
adb shell input swipe 1688 900 1688 300 300
echo scroll to bottom
node b_a/js/w.js 1
adb shell input tap 1981 925
echo enter last stage
node b_a/js/w.js 1
adb shell input tap 1926 435
node b_a/js/w.js 200
adb shell input tap 1664 614
node b_a/js/w.js 1
adb shell input tap 1380 777
node b_a/js/w.js 7 1
adb shell input keyevent KEYCODE_BACK
node b_a/js/w.js 2
for /l %%a in (1, 1, 3) do (
    adb shell input keyevent KEYCODE_BACK
    node b_a/js/w.js 1
)
adb shell input keyevent KEYCODE_BACK
node b_a/js/w.js 2

adb shell input tap 1352 938 @REM 학원교류회
node b_a/js/w.js 3
set /a r = %random% %% 3
echo random: %r%
if %r% == 0 (
    adb shell input tap 2000 345 @REM 트리니티
) else if %r% == 1 (
    adb shell input tap 2000 536 @REM 게헨나
) else (
    adb shell input tap 2000 707 @REM 밀레니엄
)
node b_a/js/w.js 3
adb shell input tap 1981 826 @REM D 스테이지
node b_a/js/w.js 1
adb shell input tap 1926 435 @REM max
node b_a/js/w.js 200
adb shell input tap 1664 614 @REM 소탕 시작 버튼
node b_a/js/w.js 1
adb shell input tap 1380 777
node b_a/js/w.js 5 1
for /l %%a in (1, 1, 4) do (
    adb shell input keyevent KEYCODE_BACK
    node b_a/js/w.js 1
)
adb shell input keyevent KEYCODE_BACK
node b_a/js/w.js 3


@REM 전술 대회
adb shell input tap 1926 901
echo tactchal
node b_a/js/w.js 4
adb shell input tap 1231 865 @REM 3픽 누르기
node b_a/js/w.js 3
adb shell input tap 1171 901 @REM 공격 편성
node b_a/js/w.js 6 1
call :screencap
node b_a/js/getPixelRGB.js 2036 889
del b_a\screen.png
for /f "tokens=*" %%a in (b_a\result.txt) do (
    if "%%a" == "112 156 188" (
        adb shell input tap 2036 889
        echo skip checked
        node b_a/js/w.js 1
    ) else (
        echo skip already checked
    )
)
adb shell input tap 2065 991 
node b_a/js/w.js 10 1
adb shell input keyevent KEYCODE_BACK 
node b_a/js/w.js 1
adb shell input tap 2185 41





@REM adb shell input tap 2028 62 @REM 우편함
@REM adb shell input tap 194 401 @REM 미션



@REM adb shell input tap %x% %y%




:End
echo.
pause
goto :eof



:screencap
adb shell wm size 1080x2340
node b_a/js/w.js
adb shell screencap sdcard/screen.png
adb shell wm size reset
adb pull sdcard/screen.png b_a/screen.png > nul 2>&1
adb shell rm sdcard/screen.png
goto :eof


@REM DEBUG; escape: 
@REM DEBUG; 2185 41 - 홈버튼
@REM DEBUG; 1900 133 - 구석