@echo off

:: Launches an app based on the package name

IF [%1] == [] goto NOPARAM
IF NOT "%1"=="-s" goto MAIN
IF "%1"=="-s" goto FORDEV

:MAIN
SETLOCAL ENABLEDELAYEDEXPANSION 
FOR /F "tokens=1,2 skip=1" %%A IN ('adb devices') DO (
    SET IS_DEV=%%B
	IF "!IS_DEV!" == "device" (
	    SET SERIAL=%%A
		
		FOR /F "tokens=* delims=  USEBACKQ" %%F IN (`devices -s !SERIAL!`) DO SET DEV=%%F
		
		echo Launching %1 on device: !DEV!
		call adb -s !SERIAL! shell am force-stop %1
		call adb -s !SERIAL! shell monkey -p %1 -c android.intent.category.LAUNCHER 1
		
		echo App launch successful.
		echo ========================================
	)
)
ENDLOCAL
goto END

:FORDEV
:: Check if the second parameter exists
IF [%2]==[] echo Please provide the serial number of the device.
IF NOT [%2]==[] call adb -s %2 shell monkey -p %3 -c android.intent.category.LAUNCHER 1
goto END

:NOPARAM
echo Please provide a package from which to launch the app.
goto :EOF

:END
echo Ready!