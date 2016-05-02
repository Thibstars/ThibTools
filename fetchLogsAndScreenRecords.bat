@echo off
SET "ARGUMENTS=%ARGUMENTS:""="%"
SETLOCAL ENABLEDELAYEDEXPANSION 
:: INSTALL ON ALL ATTACHED DEVICES ::
FOR /F "tokens=1,2 skip=1" %%A IN ('adb devices') DO (
    SET IS_DEV=%%B
	if "!IS_DEV!" == "device" (
	    SET SERIAL=%%A
	    echo "Fetching logs and screenrecord for: !SERIAL!"
	    call fetchLogs
		call fetchScreenRecords
	)
)
ENDLOCAL