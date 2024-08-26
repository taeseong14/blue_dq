cd ..





adb shell input tap 1023 974 @REM 소셜버튼
echo social button
node b_a/js/w.js 1500
adb shell input tap 500 500 @REM 서클
node b_a/js/w.js 4
adb shell input keyevent KEYCODE_BACK @REM 수령
node b_a/js/w.js 200
adb shell input keyevent KEYCODE_BACK @REM 홈
node b_a/js/w.js 4




set /p = "Press any key to continue . . . " < nul