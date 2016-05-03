@echo off
SET "ARGUMENTS=%ARGUMENTS:""="%"

SET DIR="logs"

IF EXIST "\%DIR%" goto HOME
IF NOT EXIST "\%DIR%" goto MD

:MD
md "%DIR%"
goto HOME

:HOME
SETLOCAL ENABLEDELAYEDEXPANSION 
:: INSTALL ON ALL ATTACHED DEVICES ::
FOR /F "tokens=1,2 skip=1" %%A IN ('adb devices') DO (
    SET IS_DEV=%%B
	if "!IS_DEV!" == "device" (
	    SET SERIAL=%%A
		
	    echo Fetching logs for: !SERIAL!...
		
	    call adb -s !SERIAL! logcat -v time -d>%DIR%/log_!SERIAL!.txt

		echo Successfully saved logs to folder: %DIR%.
		echo ======================================================
	)
)
echo Finished fetching logs.
ENDLOCAL