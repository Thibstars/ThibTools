@echo off

SET "ARGUMENTS=%ARGUMENTS:""="%"

SET DIR="properties"

IF EXIST "\%DIR%" goto HOME
IF NOT EXIST "\%DIR%" goto MD

:MD
md "%DIR%"
goto HOME

:HOME
SETLOCAL ENABLEDELAYEDEXPANSION 
FOR /F "tokens=1,2 skip=1" %%A IN ('adb devices') DO (
    SET IS_DEV=%%B
	IF "!IS_DEV!" == "device" (
	    SET SERIAL=%%A
		
		echo Fetching properties for !SERIAL!...
		
		call adb -s !SERIAL! shell getprop > %DIR%/props_!SERIAL!.txt
		
		echo Successfully saved properties to folder: %DIR%
		echo =====================================================
	)
)
ENDLOCAL