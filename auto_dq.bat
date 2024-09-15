@echo off
setlocal EnableDelayedExpansion

if not exist settings.txt (
    echo _SYSTEM__BRIGHTNESS_DOWN=0>settings.txt
    echo _SYSTEM__VOLUME_DOWN=0>>settings.txt
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

@REM DEBUG
@REM goto :debug

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


@REM code ______________


for /f "tokens=3 delims==" %%a in ('adb shell dumpsys window ^| findstr "mDreamingLockscreen="') do set device_locked=%%a
if %device_locked% == true (
    echo.
    echo [93m[^^!] device is locked[0m
    if exist on.bat ( call on & echo. ) else goto End
)


if %S__SYSTEM__BRIGHTNESS_DOWN% GTR 0 (
    for /l %%a in (1, 1, %S__SYSTEM__BRIGHTNESS_DOWN%) do adb shell input keyevent KEYCODE_BRIGHTNESS_DOWN
)

if %S__SYSTEM_VOLUME_DOWN% GTR 0 (
    for /l %%a in (1, 1, %S__SYSTEM_VOLUME_DOWN%) do adb shell input keyevent KEYCODE_VOLUME_DOWN
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
echo.
:loop_loading
call :screencap
node b_a/js/getPixelRGB.js 193 963 -1
for /f "tokens=*" %%a in (b_a\result.txt) do (
    if "%%a" == "243 244 244" (
        echo ready
        del b_a\screen.png b_a\result.txt
    ) else goto :loop_loading
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

if %S_AP_BUY% == 0 (
    echo no ap buying
) else (
    :loop_ap_buy
    adb shell input tap 1150 70
    node b_a/js/w.js 2
    if !S_AP_BUY! GTR 2 (
        adb shell input tap 1580 517
        set /a S_AP_BUY-=3
    ) else (
        adb shell input tap 1454 517
        if !S_AP_BUY! == 2 (
            node b_a/js/w.js 200
            adb shell input tap 1454 517
        )
        set /a S_AP_BUY=0
    )
    node b_a/js/w.js 1
    adb shell input tap 1388 788
    node b_a/js/w.js 1
    adb shell input tap 1388 788
    node b_a/js/w.js 3
    adb shell input tap 1900 133
    if !S_AP_BUY! GTR 0 (
        goto :loop_ap_buy
    )
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
for /l %%a in (1, 1, 4) do (
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
node b_a/js/w.js 14 1

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


if %S_SHOP__NORMAL_REFRESH% GTR 3 (
    echo [31mWrong Value^: SHOP__NORMAL_REFRESH setting must be ^<^= 3[0m
    goto :End
)

:loop_shop
set /a buyed = 0
set /a len = 0
for %%i in (%S_SHOP__NORMAL_BUY%) do (
    set /a len += 1
)
for /l %%a in (1,1,5) do (
    set /a x = 0
    for /l %%b in (1,1,4) do (
        set /a buy = 0
        for %%i in (%S_SHOP__NORMAL_BUY%) do (
            set /a idx = %%a * 4 - 4 + %%b
            if !idx! == %%i (
                set /a buy = %%i
                set /a buyed += 1
                echo select !buy!
            )
        )
        if !buy! NEQ 0 (
            set /a x = %%b * 250 + 1270 - 250
            adb shell input tap !x! 419
            node b_a/js/w.js 100
        )
    )
    if !buyed! NEQ %len% (
        adb shell input swipe 1672 780 1672 380 400
        node b_a/js/w.js 500
    )
)
for /l %%b in (1,1,4) do (
    set /a buy = 0
    for %%i in (%S_SHOP__NORMAL_BUY%) do (
        set /a idx = 6 * 4 - 4 + %%b
        if !idx! == %%i (
            set /a buy = 1
            echo select !idx!
        )
    )
    if !buy! == 1 (
        set /a x = %%b * 250 + 1270 - 250
        adb shell input tap !x! 660
        node b_a/js/w.js 61
    )
)
adb shell input tap 2066 980
echo buy selected
node b_a/js/w.js 300
adb shell input tap 1387 753
node b_a/js/w.js 1
for /l %%a in (1, 1, 3) do (
    adb shell input tap 1800 133
    node b_a/js/w.js 500
)

if %S_SHOP__NORMAL_REFRESH% GTR 0 (
    set /a S_SHOP__NORMAL_REFRESH -= 1
    adb shell input tap 2066 980
    node b_a/js/w.js 1
    adb shell input tap 1387 718
    node b_a/js/w.js 1
    goto :loop_shop
)

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
    node b_a/js/w.js 2
)
adb shell input keyevent KEYCODE_BACK
node b_a/js/w.js 3

@REM 하드임무 소탕
if %S_TASK__HARD_ON% == 1 (
    set /a hard_done = 0
    adb shell input tap 1480 381
    echo task
    node b_a/js/w.js 3
    adb shell input tap 1896 200
    echo task - hard
    node b_a/js/w.js 1

    for %%a in (%S_TASK__HARD_STAGE%) do (
        echo going to stage %%a
        if !hard_done! == 0 (
            for /l %%b in (1,1,30) do (
                adb shell input tap 126 536
                node b_a/js/w.js 200
            )
        )
        for /f "tokens=1,2 delims=-" %%b in ("%%a") do (
            set /a d=%%b-1
            if !hard_done! NEQ 0 (
                if %%b LSS !hard_done! (
                    set /a d = !hard_done! - %%b
                    for /l %%d in (1,1,!d!) do (
                        adb shell input tap 126 536
                        node b_a/js/w.js 200
                    )
                ) else if %%b GTR !hard_done! (
                    set /a d = %%b - !hard_done!
                    for /l %%d in (1,1,!d!) do (
                        adb shell input tap 2203 538
                        node b_a/js/w.js 200
                    )
                )
            ) else (
                for /l %%d in (1,1,!d!) do (
                    adb shell input tap 2203 538
                    node b_a/js/w.js 200
                )
            )
            if %%c == 1 (
                adb shell input tap 1982 352
            ) else if %%c == 2 ( 
                adb shell input tap 1982 548
            ) else if %%c == 3 (
                adb shell input tap 1982 748
            ) else (
                echo [31mInvalid Stage on TASK__HARD_STAGE setting[0m
                goto :End
            )
            set /a hard_done = %%b
        )
        node b_a/js/w.js 1
        adb shell input tap 1926 435
        node b_a/js/w.js 200
        adb shell input tap 1664 614
        node b_a/js/w.js 1
        adb shell input tap 1380 777
        node b_a/js/w.js 12 1
        adb shell input keyevent KEYCODE_BACK
        node b_a/js/w.js 500
        adb shell input keyevent KEYCODE_BACK
        node b_a/js/w.js 2
    )
) else (
    echo hard task turned off
)


@REM 전술 대회
adb shell input tap 1926 901
echo tactchal
node b_a/js/w.js 4

if %S_TASK__TACTCHAL_TRY% GTR 5 (
    echo [31mWrong Value^: TASK__TACTCHAL_TRY setting must be ^<^= 5[0m
    goto :End
)

:loop_tactchal
if %S_TASK__TACTCHAL_TRY% GTR 0 (
    if %S_TASK__TACTCHAL_PICK% LSS 1 (
        echo [31mWrong Value^: TASK__TACTCHAL_PICK setting must be 1, 2, or 3[0m
        goto :End
    )
    if %S_TASK__TACTCHAL_PICK% GTR 3 (
        echo [31mWrong Value^: TASK__TACTCHAL_PICK setting must be 1, 2, or 3[0m
        goto :End
    )
    set /a y = 865 - 270 * 3 + 270 * %S_TASK__TACTCHAL_PICK%

    adb shell input tap 1231 !y!
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

    set /a S_TASK__TACTCHAL_TRY -= 1
    goto :loop_tactchal
)
if %S_TASK__TACTCHAL_CLIAM_REWARD% == 1 (
    adb shell input tap 674 724
    node b_a/js/w.js 4
    adb shell input keyevent KEYCODE_BACK
    node b_a/js/w.js 1
) else (
    echo no claim reward
)

@REM 임무창
adb shell input keyevent KEYCODE_BACK
node b_a/js/w.js 3


adb shell input keyevent KEYCODE_BACK
node b_a/js/w.js 5



@REM adb shell input tap 2028 62 @REM 우편함


@REM 미션
adb shell input tap 194 401
echo mission
node b_a/js/w.js 5
adb shell input tap 2037 994
node b_a/js/w.js 7 1
adb shell input keyevent KEYCODE_BACK
node b_a/js/w.js 1
adb shell input tap 2037 994
node b_a/js/w.js 4
adb shell input keyevent KEYCODE_BACK
node b_a/js/w.js 1
adb shell input tap 1736 989
node b_a/js/w.js 100
adb shell input tap 1736 989
node b_a/js/w.js 3
adb shell input keyevent KEYCODE_BACK





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