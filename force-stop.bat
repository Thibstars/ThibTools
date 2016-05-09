@echo off

:: Force-stops a package

IF [%1] == [] goto NOPARAM
IF NOT "%1"=="-s" goto MAIN
IF "%1"=="-s" goto FORDEV

SETLOCAL ENABLEDELAYEDEXPANSION 
:MAIN
FOR /F "tokens=1,2 skip=1" %%A IN ('adb devices') DO (
    SET IS_DEV=%%B
	IF "!IS_DEV!" == "device" (
	    SET SERIAL=%%A
		
		echo Force-stopping %1 on device: !SERIAL!...
		call adb -s !SERIAL! shell am force-stop %1
		echo Force-stop successful.
		echo ========================================
	)
)
ENDLOCAL
goto END

:FORDEV
:: Check if the second parameter exists
IF [%2]==[] echo Please provide the serial number of the device.
IF NOT [%2]==[] call adb -s %2 shell am force-stop %3
goto END

:NOPARAM
echo Please provide a package to force-stop.
goto EOF

:END
echo Ready!