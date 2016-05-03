@echo off
SET "ARGUMENTS=%ARGUMENTS:""="%"

SET DIR="screenshots"

IF EXIST "\%DIR%" goto HOME
IF NOT EXIST "\%DIR%" goto MD

:MD
md "%DIR%"
goto HOME

:HOME
SETLOCAL ENABLEDELAYEDEXPANSION 
:: INSTALL ON ALL ATTACHED DEVICES ::
FOR /F "tokens=1,2 skip=1" %%A IN ('adb devices') DO (
    SET IS_DEV=%%B
	if "!IS_DEV!" == "device" (
	    SET SERIAL=%%A
		
	    echo Fetching screenshot for: !SERIAL!...
	    call adb -s !SERIAL! shell screencap -p /sdcard/screen_!SERIAL!.png
		call adb -s !SERIAL! pull /sdcard/screen_!SERIAL!.png "%DIR%"
		call adb -s !SERIAL! shell rm /sdcard/screen_!SERIAL!.png
		
		echo Successfully saved screenshot to folder: %DIR%
		echo ======================================================
	)
)
echo Finished fetching screenshots.
ENDLOCAL
pause