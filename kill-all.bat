@echo off

:: Kills active processes. Root permissions required! Without root permissions processes can't be killed.

IF NOT "%1"=="-s" goto MAIN
IF "%1"=="-s" goto FORDEV

:MAIN
SETLOCAL ENABLEDELAYEDEXPANSION 
FOR /F "tokens=1,2 skip=1" %%A IN ('adb devices') DO (
    SET IS_DEV=%%B
	IF "!IS_DEV!" == "device" (
	    SET SERIAL=%%A
		
		FOR /F "tokens=* delims=  USEBACKQ" %%F IN (`devices -s !SERIAL!`) DO SET DEV=%%F
		
		echo Killing active processes on: !DEV!
		call :KILLALL !SERIAL!
		echo ========================================
	)
)
ENDLOCAL
goto END

:FORDEV
:: Check if the second parameter exists
IF [%2]==[] echo Please provide the serial number of the device.
IF NOT [%2]==[] call :KILLALL %2
goto END

:KILLALL
adb -s %~1 root
FOR /F "tokens=2" %%B IN ('adb -s %~1 shell ps ^| findstr /V "root" ^| findstr /V "system" ^| findstr /V "NAME" ^| findstr /V "shell" ^| findstr /V "smartcard" ^| findstr /V "androidshmservice" ^| findstr /V "bluetooth" ^| findstr /V "radio" ^| findstr /V "nfc" ^| findstr /V "com.android." ^| findstr /V "android.process." ^| findstr /V "com.google.android." ^| findstr /V "com.sec.android" ^| findstr /V "com.google.process" ^| findstr /V "com.samsung.android." ^| findstr /V "com.smlds"') DO (
		
		call adb -s %~1 shell "su kill %%B"
		
		)
goto :EOF
		
:END
echo Ready^^!