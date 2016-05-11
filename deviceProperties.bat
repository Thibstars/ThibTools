@echo off

IF "%1"=="-s" goto FORDEV
IF NOT "%1"=="-s" goto MAIN

:MAIN
SETLOCAL ENABLEDELAYEDEXPANSION 
FOR /F "tokens=1,2 skip=1" %%A IN ('adb devices') DO (
    SET IS_DEV=%%B
	IF "!IS_DEV!" == "device" (
	    SET SERIAL=%%A
		
		echo Showing device properties of: !SERIAL!...
		
		IF NOT [%1]==[] call :PROPERTIES %1 !SERIAL!
		
		IF [%1]==[] call adb -s !SERIAL! shell getprop
		
		echo =======================================================
		echo[
	)
)
goto END

:PROPERTIES
IF "%~1"=="brand" call adb -s %~2 shell getprop ro.product.%~1
IF "%~1"=="device" call adb -s %~2 shell getprop ro.product.%~1
IF "%~1"=="model" call adb -s %~2 shell getprop ro.product.%~1
IF "%~1"=="name" call adb -s %~2 shell getprop ro.product.%~1
IF "%~1"=="manufacturer" call adb -s %~2 shell getprop ro.product.%~1

IF "%~1"=="serialno" call adb -s %~2 shell getprop ro.boot.%~1

IF "%~1"=="network" call adb -s %~2 shell getprop gsm.network.type
IF "%~1"=="operator" call adb -s %~2 shell getprop gsm.operator.alpha

IF "%~1"=="language" call adb -s %~2 shell getprop persist.sys.%~1
IF "%~1"=="country" call adb -s %~2 shell getprop persist.sys.%~1


IF "%~1"=="carrier" call adb -s %~2 shell getprop ro.%~1

IF "%~1"=="roaming" call adb -s %~2 shell getprop ro.com.android.dataroaming
IF "%~1"=="dateformat" call adb -s %~2 shell getprop ro.com.android.%~1

IF "%~1"=="builddate" call adb -s %~2 shell getprop ro.build.date
IF "%~1"=="release" call adb -s %~2 shell getprop ro.build.version.%~1
IF "%~1"=="sdk" call adb -s %~2 shell getprop ro.build.version.%~1

call adb -s %~2 shell getprop %~1
goto END

:FORDEV
:: Check if the second parameter exists
IF [%2]==[] echo Please provide the serial number of the device.
IF NOT [%3]==[] call :PROPERTIES %3 %2
IF [%3]==[] call adb -s %2 shell getprop
goto END

:END
ENDLOCAL