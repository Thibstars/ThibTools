@echo off

IF NOT "%1"=="-s" goto MAIN
IF "%1"=="-s" goto FORDEV

:MAIN
SETLOCAL ENABLEDELAYEDEXPANSION 
:: 25 spaces to format the output
SET "SPC=                         "

echo List of devices attached

FOR /F "tokens=1,2 skip=1" %%A IN ('adb devices') DO (
    SET IS_DEV=%%B
	IF "!IS_DEV!" == "device" (
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
		
		IF NOT "%1"=="-h" call :PRINTDEVICE !SERIAL! !DEV_BRAND! !DEV! !DEV_MODEL!
		IF "%1"=="-h" call :PRINTDEVICE -h !DEV_BRAND! !DEV! !DEV_MODEL!
	)
)
goto END

:FORDEV
:: Check if the second parameter exists
IF [%2]==[] echo Please provide the serial number of the device.
IF NOT [%2]==[] call :SINGLEDEVICE %2 %3
goto END

:SINGLEDEVICE
FOR /F "tokens=* USEBACKQ" %%F IN (`adb -s %~1 shell getprop ro.product.brand`) DO (
		SET DEV_BRAND=%%F
		)
		FOR /F "tokens=* USEBACKQ" %%F IN (`adb -s %~1 shell getprop ro.product.device`) DO (
		SET DEV=%%F
		)
		FOR /F "tokens=* USEBACKQ" %%F IN (`adb -s %~1 shell getprop ro.product.model`) DO (
		SET DEV=%%F
		)
		
IF "%~2"=="-h" goto SINGLEHUMAN	
IF NOT "%~2"=="-h" call :PRINTDEVICE %~1 %DEV_BRAND% %DEV% %DEV_MODEL%
goto :EOF

:SINGLEHUMAN
call :PRINTDEVICE -h %DEV_BRAND% %DEV% %DEV_MODEL%
goto :EOF

:PRINTDEVICE
IF %~1==-h goto PRINTHUMAN
SET "SRL=%~1 %SPC%"
SET "BRND=%~2 %SPC%"
SET "DV=%~3 %SPC%"
SET "MDL=%~4 %SPC%"

IF NOT [%~4]==[] echo %SRL:~0,25% %BRND:~0,10% %DV:~0,10% %MDL%
IF  [%~4]==[] echo %SRL:~0,25% %BRND:~0,10% %DV:~0,10%
goto :EOF

:PRINTHUMAN
SHIFT
SET "SRL=%~1 %SPC%"
SET "BRND=%~2 %SPC%"
SET "DV=%~3 %SPC%"
SET "MDL=%~4 %SPC%"

IF NOT [%~4]==[] echo %SRL:~0,10% %BRND:~0,10% %DV:~0,10% %MDL%
IF  [%~4]==[] echo %SRL:~0,10% %BRND:~0,10% %DV:~0,10%
goto :EOF

:END
ENDLOCAL