@echo off
SET ARGUMENTS=%~1

if "%ARGUMENTS%" == "" (
    GOTO EOF
)

SET "ARGUMENTS=%ARGUMENTS:""="%"
SETLOCAL ENABLEDELAYEDEXPANSION 
:: INSTALL ON ALL ATTACHED DEVICES ::
FOR /F "tokens=1,2 skip=1" %%A IN ('adb devices') DO (
    SET IS_DEV=%%B
	if "!IS_DEV!" == "device" (
	    SET SERIAL=%%A
				
		FOR /F "tokens=* USEBACKQ" %%F IN (`adb -s !SERIAL! shell getprop ro.product.brand`) DO (
		SET DEV_BRAND=%%F
		)
		FOR /F "tokens=* USEBACKQ" %%F IN (`adb -s !SERIAL! shell getprop ro.product.device`) DO (
		SET DEV=%%F
		)
		FOR /F "tokens=* USEBACKQ" %%F IN (`adb -s !SERIAL! shell getprop ro.product.model`) DO (
		SET DEV=%%F
		)
		
		SET "DEV_INFO=!DEV_BRAND! !DEV! !DEV_MODEL!"			

		FOR %%s IN (%DEV_INFO%) DO (
		SET "var=%%sxyz"
		svn co "!var!"
		)
		
	    echo "adb -s !SERIAL! %ARGUMENTS%"
	    start "ADB+P Running on  [!SERIAL!] !DEV_INFO!" adb -s !SERIAL! %ARGUMENTS%
	)
)
ENDLOCAL
:EOF