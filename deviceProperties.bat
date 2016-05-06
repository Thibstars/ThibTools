@echo off

IF "%1"=="-s" goto FORDEV

SETLOCAL ENABLEDELAYEDEXPANSION 
:MAIN
FOR /F "tokens=1,2 skip=1" %%A IN ('adb devices') DO (
    SET IS_DEV=%%B
	IF "!IS_DEV!" == "device" (
	    SET SERIAL=%%A
		
		call adb -s !SERIAL! shell getprop
		echo =======================================================
		echo[
	)
)
goto END

:SIMPLECOMMAND
IF "%3"=="brand" call adb -s %2 shell getprop ro.product.%3
IF "%3"=="device" call adb -s %2 shell getprop ro.product.%3
IF "%3"=="model" call adb -s %2 shell getprop ro.product.%3
IF "%3"=="name" call adb -s %2 shell getprop ro.product.%3
IF "%3"=="manufacturer" call adb -s %2 shell getprop ro.product.%3

IF "%3"=="serialno" call adb -s %2 shell getprop ro.boot.%3

IF "%3"=="network" call adb -s %2 shell getprop gsm.network.type
IF "%3"=="operator" call adb -s %2 shell getprop gsm.operator.alpha

IF "%3"=="language" call adb -s %2 shell getprop persist.sys.%3
IF "%3"=="country" call adb -s %2 shell getprop persist.sys.%3


IF "%3"=="carrier" call adb -s %2 shell getprop ro.%3

IF "%3"=="roaming" call adb -s %2 shell getprop ro.com.android.dataroaming
IF "%3"=="dateformat" call adb -s %2 shell getprop ro.com.android.%3

IF "%3"=="builddate" call adb -s %2 shell getprop ro.build.date
IF "%3"=="release" call adb -s %2 shell getprop ro.build.version.%3
IF "%3"=="sdk" call adb -s %2 shell getprop ro.build.version.%3

goto NOSIMPLE

:FORDEV
:: Check if the second parameter exists
IF [%2]==[] echo Please provide the serial number of the device.
IF NOT [%3]==[] goto SIMPLECOMMAND
:NOSIMPLE
:: Get the properties for the specific device, if a third parameter is given it will be used.
IF NOT [%2]==[] call adb -s %2 shell getprop %3
goto END

:END
ENDLOCAL