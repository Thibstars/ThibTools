@echo off
SET "ARGUMENTS=%ARGUMENTS:""="%"

SET DIR="screenshots"

IF EXIST "\%DIR%" goto HOME
goto MD

:MD
IF NOT EXIST "\%DIR%" md "%DIR%"
goto HOME

:HOME
SETLOCAL ENABLEDELAYEDEXPANSION 
:: INSTALL ON ALL ATTACHED DEVICES ::
FOR /F "tokens=1,2 skip=1" %%A IN ('adb devices') DO (
    SET IS_DEV=%%B
	if "!IS_DEV!" == "device" (
	    SET SERIAL=%%A
		
		FOR /F "tokens=* delims=  USEBACKQ" %%F IN (`devices -s !SERIAL!`) DO SET DEV=%%F
		
	    echo Fetching screenshot for: !DEV!
	    call adb -s !SERIAL! shell screencap -p /sdcard/screen_!SERIAL!.png
		call adb -s !SERIAL! pull /sdcard/screen_!SERIAL!.png "%DIR%"
		call adb -s !SERIAL! shell rm /sdcard/screen_!SERIAL!.png
		
		echo Successfully saved screenshot to folder: %DIR%
		echo ======================================================
	)
)
echo Finished fetching screenshots.
ENDLOCAL