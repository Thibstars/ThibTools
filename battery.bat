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
		
		FOR /F "tokens=* delims=  USEBACKQ" %%F IN (`devices -s !SERIAL!`) DO SET DEV=%%F
		
		echo Battery info for: !DEV!
		
		call :BATTERY !SERIAL! %1
		echo ========================================
	)
)
ENDLOCAL
goto :EOF

:FORDEV
:: Check if the second parameter exists
IF [%2]==[] echo Please provide the serial number of the device.
IF NOT [%2]==[] call :BATTERY %2 %3
goto :EOF

:BATTERY
IF [%~2]==[] call adb -s %~1 shell dumpsys battery
IF NOT [%2]==[] call :FILTERED %~1 %~2
goto :EOF

:FILTERED
call adb -s %~1 shell dumpsys battery > batteryinfo.txt
IF "%~2"=="charge" call :CHARGE %~2
IF NOT "%~2"=="charge" call :FINDINFO %~2
goto :EOF

:FINDINFO
FOR /F "tokens=* delims=  USEBACKQ" %%F IN (`findstr /i %~1 batteryinfo.txt`) DO echo %%F
del batteryinfo.txt
goto :EOF

:CHARGE
SET LVL=""
SET SCL=""
FOR /F "tokens=* delims=  USEBACKQ" %%F IN (`findstr /i "level" batteryinfo.txt`) DO SET LVL=%%F
FOR /F "tokens=* delims=  USEBACKQ" %%F IN (`findstr /i "scale" batteryinfo.txt`) DO SET SCL=%%F
del batteryinfo.txt
echo Charge: %LVL:~8%/%SCL:~9%