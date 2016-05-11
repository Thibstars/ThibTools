@echo off

SET DIR="bugreports"

IF EXIST "\%DIR%" goto HOME
IF NOT EXIST "\%DIR%" goto MD

:MD
md "%DIR%"
goto HOME

:HOME
echo NOTE: Fetching bug reports might take a while. Please be patient.
SETLOCAL ENABLEDELAYEDEXPANSION 
FOR /F "tokens=1,2 skip=1" %%A IN ('adb devices') DO (
    SET IS_DEV=%%B
	IF "!IS_DEV!" == "device" (
	    SET SERIAL=%%A
		
		echo Fetching bug report for !SERIAL!...
		
		call adb -s !SERIAL! bugreport > %DIR%/report_!SERIAL!.txt
		
		echo Successfully saved bug report to folder: %DIR%
		echo =====================================================
	)
)
ENDLOCAL
