@echo off
setlocal EnableDelayedExpansion

@REM 사용자 맞춤 설정들
if not exist settings.txt (
    echo _SYSTEM__BRIGHTNESS_DOWN=0 > settings.txt
    echo _SYSTEM__SOUND_DOWN=0 >> settings.txt
    echo AP_BUY=0 >> settings.txt
    echo SHOP__NORMAL_BUY=1 >> settings.txt
    echo SHOP__NORMAL_REFRESH=0 >> settings.txt
    echo SHOP__TACTCHAL_ON=0 >> settings.txt
    echo SHOP__TACTCHAL_BUY=5,6 >> settings.txt
    echo SHOP__TACTCHAL_REFRESH=0 >> settings.txt
    echo TASK__A_USE=1 >> settings.txt
    echo TASK__A_PICK=0 >> settings.txt
    echo TASK__B_USE=1 >> settings.txt
    echo TASK__B_PICK=0 >> settings.txt
    echo TASK__TACTCHAL_TRY=1 >> settings.txt
    echo TASK__TACTCHAL_PICK=3 >> settings.txt
    echo TASK__TACTCHAL_CLIAM_REWARD=0 >> settings.txt
    echo TASK__HARD_ON=0 >> settings.txt
    echo TASK__HARD_STAGE=15-2 >> settings.txt
)

cd ..
goto :Line
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
    echo "enter ip and port of device to connect"
    set /p ip="ip: "
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


node b_a/js/w.js 40 1

adb shell input tap 369 1017 @REM 오늘 하루 보지 않기
node b_a/js/w.js 200
adb shell input tap %x% %y% @REM touch to start
echo game started

node b_a/js/w.js 30 1

adb shell input tap %x% %y% @REM 출석 보상

node b_a/js/w.js 3500 1

adb shell input tap %x% %y% @REM 메모리얼 스킵
echo memorial skipping
node b_a/js/w.js 700
adb shell input tap 1380 777 @REM 확인

node b_a/js/w.js 6 1
adb shell input tap 2077 86 @REM 공지 x
echo notice closed

node b_a/js/w.js 3 1

adb shell input tap 1900 133
node b_a/js/w.js 500
adb shell input tap 1900 133 @REM 구석 터치 공월 수령
echo claim monthly reward
node b_a/js/w.js 2 1
adb shell input tap 1900 133
echo closing things
node b_a/js/w.js 500
adb shell input tap 1900 133
node b_a/js/w.js 500
adb shell input tap 1900 133
node b_a/js/w.js 500
adb shell input tap 1900 133
node b_a/js/w.js 500
adb shell input tap 1900 133 @REM 대충 구석 터치
node b_a/js/w.js 3

adb shell input tap 241 974 @REM 카페 들가기
echo opening cafe
node b_a/js/w.js 9 1

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
node b_a/js/w.js 9 1
adb shell input tap 2000 500 @REM 대충 오른쪽 탭

node b_a/js/w.js 1
@REM TODO: 카페 학생 탭하기 (2호점)

adb shell input tap 2185 41 @REM 홈버튼
node b_a/js/w.js 9 1

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
node b_a/js/w.js 3

adb shell input tap 1435 974 @REM 상점
echo shop
node b_a/js/w.js 4
adb shell input tap 1275 408 @REM 회색보고서 선택
adb shell input tap 2066 980 @REM 선택 구매
node b_a/js/w.js 300
adb shell input tap 1387 753 @REM 확인
node b_a/js/w.js 2
adb shell input keyevent KEYCODE_BACK @REM 뒤로
node b_a/js/w.js 100
adb shell input keyevent KEYCODE_BACK @REM 뒤로
node b_a/js/w.js 4

adb shell input tap 2122 827 @REM 업무
node b_a/js/w.js 5 1

adb shell input tap 1352 655 @REM 현상수배
node b_a/js/w.js 3
set /a r = %random% %% 3
echo random: %r%
if %r% == 0 (
    adb shell input tap 2000 345 @REM 고가도로
) else if %r% == 1 (
    adb shell input tap 2000 536 @REM 기찻길
) else (
    adb shell input tap 2000 707 @REM 교실
)
node b_a/js/w.js 2
adb shell input swipe 1688 900 1688 300 300 @REM 맽 밑으로
node b_a/js/w.js 1
adb shell input tap 1981 925 @REM 입장 마지막
node b_a/js/w.js 1
adb shell input tap 1926 435 @REM max
node b_a/js/w.js 200
adb shell input tap 1664 614 @REM 소탕 시작 버튼
node b_a/js/w.js 1
adb shell input tap 1380 777 @REM 확인
node b_a/js/w.js 7 1
adb shell input keyevent KEYCODE_BACK @REM skip
node b_a/js/w.js 2
adb shell input keyevent KEYCODE_BACK @REM 뒤로
node b_a/js/w.js 1
adb shell input keyevent KEYCODE_BACK @REM 창닫기
node b_a/js/w.js 1
adb shell input keyevent KEYCODE_BACK @REM 뒤로
node b_a/js/w.js 1
adb shell input keyevent KEYCODE_BACK @REM 뒤로
node b_a/js/w.js 2

adb shell input tap 1352 938 @REM 학원교류회
node b_a/js/w.js 3
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
node b_a/js/w.js 3
adb shell input tap 1981 826 @REM D 스테이지
node b_a/js/w.js 1
adb shell input tap 1926 435 @REM max
node b_a/js/w.js 200
adb shell input tap 1664 614 @REM 소탕 시작 버튼
node b_a/js/w.js 1
adb shell input tap 1380 777 @REM 확인
node b_a/js/w.js 5 1
adb shell input keyevent KEYCODE_BACK @REM skip
node b_a/js/w.js 1
adb shell input keyevent KEYCODE_BACK @REM 뒤로
node b_a/js/w.js 1
adb shell input keyevent KEYCODE_BACK @REM 창닫기
node b_a/js/w.js 1
adb shell input keyevent KEYCODE_BACK @REM 뒤로
node b_a/js/w.js 1
adb shell input keyevent KEYCODE_BACK @REM 뒤로
node b_a/js/w.js 3


:Line
adb shell input tap 1926 901 @REM 전술 대회
node b_a/js/w.js 4
adb shell input tap 1231 865 @REM 3픽 누르기
node b_a/js/getPixelRGB.js 2036 889
node b_a/js/w.js 3
adb shell input tap 1171 901 @REM 공격 편성
node b_a/js/w.js 6 1
call :screencap
node b_a/js/getPixelRGB.js 2036 889
del b_a\screen.png
for /f "tokens=*" %%a in (b_a\result.txt) do set a=%%a 

if "%a%" == "112 156 188 " (
    adb shell input tap 2036 889 @REM 전투 스킵 체크박스
    echo skip checked
    node b_a/js/w.js 1
) else (
    echo skip already checked
)
adb shell input tap 2065 991 @REM 출격
node b_a/js/w.js 10 1
adb shell input keyevent KEYCODE_BACK @REM 닫기
node b_a/js/w.js 1
adb shell input tap 2185 41 @REM 홈버튼





@REM adb shell input tap 2028 62 @REM 우편함
@REM adb shell input tap 194 401 @REM 미션



@REM adb shell input tap %x% %y%



@REM TODO: ./READMD.md#47
@REM timeout /t 30 /nobreak





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
