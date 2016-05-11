@echo off

:: Print the path to the APK of the given package.

IF NOT "%1"=="-s" goto MAIN
IF "%1"=="-s" goto FORDEV

:MAIN
SETLOCAL ENABLEDELAYEDEXPANSION 
FOR /F "tokens=1,2 skip=1" %%A IN ('adb devices') DO (
    SET IS_DEV=%%B
	IF "!IS_DEV!" == "device" (
	    SET SERIAL=%%A
		
		echo Path to apk of %1 on device: !SERIAL!...
		call adb -s !SERIAL! shell pm path %1
		echo ========================================
	)
)
ENDLOCAL
goto END

:FORDEV
:: Check if the second parameter exists
IF [%2]==[] echo Please provide the serial number of the device.
IF NOT [%2]==[] call adb -s %2 shell pm path %3
goto END

:END
echo Ready!