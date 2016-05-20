@echo off

SET DIR="bugreports"

IF EXIST "\%DIR%" goto HOME
goto MD

:MD
IF NOT EXIST "\%DIR%" md "%DIR%"
goto HOME

:HOME
echo NOTE: Fetching bug reports might take a while. Please be patient.
SETLOCAL ENABLEDELAYEDEXPANSION 
FOR /F "tokens=1,2 skip=1" %%A IN ('adb devices') DO (
    SET IS_DEV=%%B
	IF "!IS_DEV!" == "device" (
	    SET SERIAL=%%A
		
		FOR /F "tokens=* delims=  USEBACKQ" %%F IN (`devices -s !SERIAL!`) DO SET DEV=%%F
		
		echo Fetching bug report for !DEV!
		
		call adb -s !SERIAL! bugreport > %DIR%/report_!SERIAL!.txt
		
		echo Successfully saved bug report to folder: %DIR%
		echo =====================================================
	)
)
ENDLOCAL
