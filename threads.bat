@echo off

:: Lists the active threads.

IF NOT "%1"=="-s" goto MAIN
IF "%1"=="-s" goto FORDEV

:MAIN
SETLOCAL ENABLEDELAYEDEXPANSION 
FOR /F "tokens=1,2 skip=1" %%A IN ('adb devices') DO (
    SET IS_DEV=%%B
	IF "!IS_DEV!" == "device" (
	    SET SERIAL=%%A
		
		FOR /F "tokens=* delims=  USEBACKQ" %%F IN (`devices -s !SERIAL!`) DO SET DEV=%%F
		
		echo Showing threads on: !DEV!
		
		:: TODO: run the following in separate windows (for some strange reason, adb+p does not work with this..., using start waits for a ctrl+c and then opens the next window...)
		IF NOT [%3]==[] call adb -s !SERIAL! shell top -t | findstr /I "%1"
		IF [%3]==[] call adb -s !SERIAL! shell top -t
		echo ========================================
	)
)
ENDLOCAL
goto END

:FORDEV
:: Check if the second parameter exists
IF [%2]==[] echo Please provide the serial number of the device.
IF NOT [%2]==[] goto CHECKPKG

:HASPKG
call adb -s %2 shell top -t | findstr /I "%3"
goto END
:HASNOPKG

call adb -s %2 shell top -t
goto END

:CHECKPKG
IF NOT [%3]==[] goto HASPKG
IF [%3]==[] goto HASNOPKG

:END
echo Ready!