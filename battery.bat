@echo off

:: Displays battery information.

IF NOT "%1"=="-s" goto MAIN
IF "%1"=="-s" goto FORDEV

:MAIN
SETLOCAL ENABLEDELAYEDEXPANSION 
FOR /F "tokens=1,2 skip=1" %%A IN ('adb devices') DO (
    SET IS_DEV=%%B
	IF "!IS_DEV!" == "device" (
	    SET SERIAL=%%A
		
		echo Battery info for: !SERIAL!...
		call adb -s !SERIAL! shell dumpsys battery
		echo ========================================
	)
)
ENDLOCAL
goto END

:FORDEV
:: Check if the second parameter exists
IF [%2]==[] echo Please provide the serial number of the device.
IF NOT [%2]==[] call adb -s %2 shell dumpsys battery
goto END

:END
echo Ready!