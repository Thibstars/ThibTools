@echo off

:: Deletes all data associated with a package.

IF [%1] == [] goto NOPARAM
IF NOT "%1"=="-s" goto MAIN
IF "%1"=="-s" goto FORDEV

SETLOCAL ENABLEDELAYEDEXPANSION 
:MAIN
FOR /F "tokens=1,2 skip=1" %%A IN ('adb devices') DO (
    SET IS_DEV=%%B
	IF "!IS_DEV!" == "device" (
	    SET SERIAL=%%A
		
		echo Clearing data of %1 on device: !SERIAL!...
		call adb -s !SERIAL! shell pm clear %1
		echo Sucessfully cleared data.
		echo ==========================================
	)
)
ENDLOCAL
goto END

:FORDEV
:: Check if the second parameter exists
IF [%2]==[] goto NOSERIAL 
IF NOT [%2]==[] call adb -s %2 shell pm clear %3
goto END

:NOSERIAL 
echo Please provide the serial number of the device.
goto EOF

:NOPARAM
echo Please provide a package to clear its data.
goto EOF

:END
echo Ready!