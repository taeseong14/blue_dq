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
    node b_a/js/w.js 2
    goto ConnectDevice
) else if !devices! GTR 1 ( @REM using more than 1 device
    echo [^^!] connected device more than 1
    adb disconnect
    echo "enter port of device to connect"
    set /p port="port: "
    adb connect !ip!:!port! @REM DEBUG:TODO - ip 위꺼 지우고 여따 박기
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
@REM 내껀 2340x1080



set /a x = screenX / 2
set /a y = screenY / 2


node b_a/js/w.js 35 1

adb shell input tap 369 1017 @REM 오늘 하루 보지 않기
node b_a/js/w.js 200
adb shell input tap %x% %y% @REM touch to start
echo game started

node b_a/js/w.js 30 1

adb shell input tap %x% %y% @REM 출석 보상

node b_a/js/w.js 3500 1

adb shell input tap %x% %y% @REM 메모리얼 스킵
echo memorial skipping
node b_a/js/w.js 400
adb shell input tap 1380 777 @REM 확인

node b_a/js/w.js 4500 1
adb shell input tap 2077 86 @REM 공지 x
echo notice closed

node b_a/js/w.js 3 1

adb shell input tap 1900 133
node b_a/js/w.js 500
adb shell input tap 1900 133 @REM 구석 터치 공월 수령
node b_a/js/w.js 1
adb shell input tap 1900 133
node b_a/js/w.js 500
adb shell input tap 1900 133
node b_a/js/w.js 500
adb shell input tap 1900 133
node b_a/js/w.js 500
adb shell input tap 1900 133
node b_a/js/w.js 500
adb shell input tap 1900 133 @REM 대충 구석 터치
node b_a/js/w.js 3



@REM TODO: 아이템 기한 만료시 스샷 찍기, 몇초 기다려야하는지 확인

adb shell input tap 1900 133
node b_a/js/w.js 500
adb shell input tap 1900 133 @REM 구석 터치 창들 닫기


adb shell input tap 241 974 @REM 카페 들가기
echo opening cafe
node b_a/js/w.js 7

adb shell input tap 2000 500 @REM 대충 오른쪽 탭
node b_a/js/w.js 1

@REM @REM TODO: 카페 학생 탭하기

adb shell input tap 2024 959 @REM 카페 수익
node b_a/js/w.js 1
adb shell input tap 1170 824 @REM 수령
node b_a/js/w.js 3
adb shell input tap 1900 133
node b_a/js/w.js 500
adb shell input tap 1900 133
node b_a/js/w.js 500
adb shell input tap 1900 133 @REM 구석 터치 창들 닫기
node b_a/js/w.js 500
adb shell input tap 286 166 @REM 카페 이동
node b_a/js/w.js 1
adb shell input tap 500 272 @REM 2호점
node b_a/js/w.js 7
adb shell input tap 2000 500 @REM 대충 오른쪽 탭

node b_a/js/w.js 1
@REM TODO: 카페 학생 탭하기 (2호점)

adb shell input tap 2185 41 @REM 홈버튼
node b_a/js/w.js 7

@REM adb shell input tap 432 974 @REM TODO: 스케쥴

adb shell input tap 1023 974 @REM 소셜버튼
echo social button
node b_a/js/w.js 1500
adb shell input tap 500 500 @REM 서클
node b_a/js/w.js 4
adb shell input tap 2185 41 @REM 홈버튼
node b_a/js/w.js 200
adb shell input tap 2185 41 @REM 홈버튼
node b_a/js/w.js 4

adb shell input tap 1239 974 @REM 제조
node b_a/js/w.js 2
adb shell input tap 2000 983 @REM 일괄 수령
node b_a/js/w.js 4
adb shell input tap 1900 133 @REM 받기
node b_a/js/w.js 500
adb shell input tap 1592 983 @REM 빠른 제조
node b_a/js/w.js 2
adb shell input tap 1968 930 @REM 제조 시작
node b_a/js/w.js 1
adb shell input tap 1380 777 @REM 확인
node b_a/js/w.js 1
adb shell input tap 2185 41 @REM 홈버튼
node b_a/js/w.js 2

adb shell input tap 1435 974 @REM 상점
node b_a/js/w.js 3
adb shell input tap 1275 408 @REM 회색보고서 선택
adb shell input tap 2066 980 @REM 선택 구매
node b_a/js/w.js 300
adb shell input tap 1387 753 @REM 확인
node b_a/js/w.js 2
adb shell input keyevent KEYCODE_BACK @REM 뒤로
node b_a/js/w.js 100
adb shell input keyevent KEYCODE_BACK @REM 뒤로
node b_a/js/w.js 2

adb shell input tap 2122 827 @REM 업무
node b_a/js/w.js 3

adb shell input tap 1352 655 @REM 현상수배
node b_a/js/w.js 2
set /a r = %random% %% 3
echo random: %r%
if %r% == 0 (
    adb shell input tap 2000 345 @REM 고가도로
) else if %r% == 1 (
    adb shell input tap 2000 536 @REM 기찻길
) else (
    adb shell input tap 2000 707 @REM 교실
)
node b_a/js/w.js 1
adb shell input swipe 1688 900 1688 300 300 @REM 맽 밑으로
node b_a/js/w.js 1
adb shell input tap 1981 925 @REM 입장 마지막
node b_a/js/w.js 1
adb shell input tap 1926 435 @REM max
node b_a/js/w.js 200
adb shell input tap 1664 614 @REM 소탕 시작 버튼
node b_a/js/w.js 1
adb shell input tap 1380 777 @REM 확인
node b_a/js/w.js 5
adb shell input keyevent KEYCODE_BACK @REM skip
node b_a/js/w.js 700
adb shell input keyevent KEYCODE_BACK @REM 뒤로
node b_a/js/w.js 1
adb shell input keyevent KEYCODE_BACK @REM 창닫기
node b_a/js/w.js 400
adb shell input keyevent KEYCODE_BACK @REM 뒤로
node b_a/js/w.js 1
adb shell input keyevent KEYCODE_BACK @REM 뒤로
node b_a/js/w.js 2

adb shell input tap 1352 938 @REM 학원교류회
node b_a/js/w.js 2
@REM @REM TODO: 랜덤 활성화, 지금은 내가 게헨나 말고 D를 못깼기에 게한나로 고정.
@REM set /a r = %random% %% 3
@REM echo random: %r%
@REM if %r% == 0 (
@REM     adb shell input tap 2000 345 @REM 트리니티
@REM ) else if %r% == 1 (
@REM     adb shell input tap 2000 536 @REM 게헨나
@REM ) else (
@REM     adb shell input tap 2000 707 @REM 밀레니엄
@REM )
adb shell input tap 2000 536 @REM 게헨나 고정 따이
echo debug; gehenna selected
node b_a/js/w.js 2
adb shell input tap 1981 826 @REM D 스테이지
node b_a/js/w.js 1
adb shell input tap 1926 435 @REM max
node b_a/js/w.js 200
adb shell input tap 1664 614 @REM 소탕 시작 버튼
node b_a/js/w.js 1
adb shell input tap 1380 777 @REM 확인
node b_a/js/w.js 5
adb shell input keyevent KEYCODE_BACK @REM skip
node b_a/js/w.js 700
adb shell input keyevent KEYCODE_BACK @REM 뒤로
node b_a/js/w.js 1
adb shell input keyevent KEYCODE_BACK @REM 창닫기
node b_a/js/w.js 1
adb shell input keyevent KEYCODE_BACK @REM 뒤로
node b_a/js/w.js 1
adb shell input keyevent KEYCODE_BACK @REM 뒤로
node b_a/js/w.js 2


@REM @REM TODO: 전술대회
adb shell input tap 1926 901 @REM 전술 대회
@REM node b_a/js/w.js 4





@REM adb shell input tap 2028 62 @REM 우편함
@REM adb shell input tap 194 401 @REM 미션



@REM adb shell input tap %x% %y%



@REM TODO: ./READMD.md#47
@REM timeout /t 30 /nobreak





:End
echo.
set /p a="Enter to continue"
goto :eof



:screencap
adb shell screencap sdcard/screen.png
adb pull sdcard/screen.png b_a/screen.png > nul 2>&1
adb shell rm sdcard/screen.png
goto :eof


@REM DEBUG; escape: 
