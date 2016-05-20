@echo off

SET DIR="properties"

IF EXIST "\%DIR%" goto HOME
goto MD

:MD
IF NOT EXIST "\%DIR%" md "%DIR%"
goto HOME

:HOME
SETLOCAL ENABLEDELAYEDEXPANSION 
FOR /F "tokens=1,2 skip=1" %%A IN ('adb devices') DO (
    SET IS_DEV=%%B
	IF "!IS_DEV!" == "device" (
	    SET SERIAL=%%A		
		
		FOR /F "tokens=* delims=  USEBACKQ" %%F IN (`devices -s !SERIAL!`) DO SET DEV=%%F
		
		echo Fetching properties for !DEV!
		
		call adb -s !SERIAL! shell getprop > %DIR%/props_!SERIAL!.txt
		
		echo Successfully saved properties to folder: %DIR%
		echo =====================================================
	)
)
ENDLOCAL