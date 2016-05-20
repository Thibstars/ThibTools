@echo off
SET "ARGUMENTS=%ARGUMENTS:""="%"

SET DIR="logs"

IF EXIST "\%DIR%" goto HOME
goto MD

:MD
IF NOT EXIST "\%DIR%" md "%DIR%"
goto HOME

:HOME
SETLOCAL ENABLEDELAYEDEXPANSION 
:: INSTALL ON ALL ATTACHED DEVICES ::
FOR /F "tokens=1,2 skip=1" %%A IN ('adb devices') DO (
    SET IS_DEV=%%B
	if "!IS_DEV!" == "device" (
	    SET SERIAL=%%A
		
		FOR /F "tokens=* delims=  USEBACKQ" %%F IN (`devices -s !SERIAL!`) DO SET DEV=%%F
		
	    echo Fetching logs for: !DEV!
		
	    call adb -s !SERIAL! logcat -v time -d>%DIR%/log_!SERIAL!.txt

		echo Successfully saved logs to folder: %DIR%.
		echo ======================================================
	)
)
echo Finished fetching logs.
ENDLOCAL