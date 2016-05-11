@echo off

:: Tests the connection and latency between two network connections.

IF NOT "%1"=="-s" goto MAIN
IF "%1"=="-s" goto FORDEV

:MAIN
SETLOCAL ENABLEDELAYEDEXPANSION 
FOR /F "tokens=1,2 skip=1" %%A IN ('adb devices') DO (
    SET IS_DEV=%%B
	IF "!IS_DEV!" == "device" (
	    SET SERIAL=%%A
		
		echo Pinging %1 on: !SERIAL!...
		echo ========================================
	)
)
@call ADB+P "-s !SERIAL! shell ping %1"> nul
ENDLOCAL
goto END

:FORDEV
:: Check if the second parameter exists
IF [%2]==[] echo Please provide the serial number of the device.
IF NOT [%2]==[] call adb -s %2 shell ping %3
goto END

:END
echo Ready!