@echo off

:: Shows IP address.

IF NOT "%1"=="-s" goto MAIN
IF "%1"=="-s" goto FORDEV

:MAIN
SETLOCAL ENABLEDELAYEDEXPANSION 
FOR /F "tokens=1,2 skip=1" %%A IN ('adb devices') DO (
    SET IS_DEV=%%B
	IF "!IS_DEV!" == "device" (
	    SET SERIAL=%%A
		
		FOR /F "tokens=* delims=  USEBACKQ" %%F IN (`devices -s !SERIAL!`) DO SET DEV=%%F
		
		echo IP address of: !DEV!
		call :SHOWIP !SERIAL!
		echo ========================================
	)
)
ENDLOCAL
goto END

:FORDEV
:: Check if the second parameter exists
IF [%2]==[] echo Please provide the serial number of the device.
IF NOT [%2]==[] call :SHOWIP %2
goto :EOF

:SHOWIP
SET IP=""
FOR /F "tokens=* delims= USEBACKQ" %%F IN (`adb -s %~1 shell ip -f inet addr show wlan0 ^| findstr /R "[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*"`) DO SET IP=%%F
echo %IP%
goto :EOF

:END
echo Ready^^!