@echo off
setlocal EnableDelayedExpansion

cd ..

:loop
call :screencap
node b_a/js/getPixelRGB.js 398 187 0
for /f "tokens=*" %%a in (b_a\result.txt) do (
    if "%%a" == "240 68 0" (
        del b_a\screen.png b_a\result.txt
    ) else (
        echo not in main screen or no chat to read
        goto :loop
    )
)

adb shell input tap 375 230

node b_a/js/w.js 2

adb shell input tap 372 399

node b_a/js/w.js 1

set /a stu = 0

:loop1
set /a stu += 1
call :screencap
node b_a/js/getPixelRGB.js 1200 354 0
for /f "tokens=*" %%a in (b_a\result.txt) do (
    if "%%a" NEQ "251 71 25" (
    del b_a\screen.png b_a\result.txt
        echo no chat
        if !stu! NEQ 0 echo ended with studetn !stu!
        goto :End
    )
)

adb shell input tap 800 354
echo student !stu!

set /a loop2ed = 0
echo.
:loop2
set /a loop2ed += 1
echo [2K[1A[2Ktouching !loop2ed! ^(^>7 ^-^> err^)
adb shell input swipe 1700 700 1700 500 300
node b_a/js/w.js 1
call :screencap
node b_a/js/getPixelRGB.js 1749 846 0
for /f "tokens=*" %%a in (b_a\result.txt) do (
    if "%%a" NEQ "255 237 240" (
        if "%%a" == "119 222 255" (
            echo err: goto loop 1
            set /a stu -= 1
            adb shell input tap 372 249
            node b_a/js/w.js 1
            adb shell input tap 372 399
            node b_a/js/w.js 1
            goto :loop1
        )
        set /a i = 0
        del b_a\screen.png b_a\result.txt
        :loop3
        if !i! == 0 (
            set /a y = 900
        ) else (
            set /a y = 900 - 120 - 80 * !i!
        )
        set /a i += 1
        adb shell input tap 1700 !y!
        if !i! LSS 8 (
            node b_a/js/w.js 100
            goto :loop3
        )
        if !loop2ed! GTR 7 (
            echo err: goto loop 1
            adb shell input tap 372 249
            node b_a/js/w.js 1
            adb shell input tap 372 399
            node b_a/js/w.js 1
            set /a stu -= 1
            goto :loop1
        )
        node b_a/js/w.js 3
        goto :loop2
    )
)

adb shell input tap 1700 926
node b_a/js/w.js 1
adb shell input tap 1700 885

node b_a/js/w.js 8 1

adb shell input tap 2133 66
node b_a/js/w.js 1
adb shell input tap 2139 206
node b_a/js/w.js 1
adb shell input tap 1391 818
node b_a/js/w.js 4
adb shell input keyevent KEYCODE_BACK
node b_a/js/w.js 1

adb shell input tap 372 249
node b_a/js/w.js 1
adb shell input tap 372 399
node b_a/js/w.js 1
goto :loop1


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

