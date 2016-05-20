@echo off
SET "ARGUMENTS=%ARGUMENTS:""="%"

SET REQ_API=19
SET DIR="videos"

IF EXIST "\%DIR%" goto HOME
IFgoto MD

:MD
 NOT EXIST "\%DIR%" md "%DIR%"
goto HOME

:HOME
SETLOCAL ENABLEDELAYEDEXPANSION 
:: INSTALL ON ALL ATTACHED DEVICES ::
FOR /F "tokens=1,2 skip=1" %%A IN ('adb devices') DO (
    SET IS_DEV=%%B
	IF "!IS_DEV!" == "device" (
	    SET SERIAL=%%A
		
		echo ======================================================
		
		:: Check the API level
		FOR /F "tokens=* USEBACKQ" %%F IN (`adb -s !SERIAL! shell getprop ro.build.version.sdk`) DO (
		SET API=%%F
		)
		IF NOT !API! GEQ %REQ_API% (
		echo API Level %REQ_API% or higher is required to record the screen.
		echo Installed API level on !SERIAL!: !API!
		)
		
		:: Proceed if supported
		IF !API! GEQ %REQ_API% (
		
		FOR /F "tokens=* delims=  USEBACKQ" %%F IN (`devices -s !SERIAL!`) DO SET DEV=%%F
		
		echo Fetching screenrecord for: !DEV!
		
	    call adb -s !SERIAL! shell screenrecord /sdcard/video_!SERIAL!.mp4
		call adb -s !SERIAL! pull /sdcard/video_!SERIAL!.mp4 %DIR%/video_!SERIAL!.mp4
		call adb -s !SERIAL! shell rm /sdcard/video_!SERIAL!.mp4
		
		echo Successfully saved video recording to folder: %DIR%.
		echo ======================================================
		)
	)
)
echo Finished fetching screen records.
ENDLOCAL