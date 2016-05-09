@echo off

for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set "DEL=%%a"
)

SET "SPACING=               "

IF "%~1" == "" goto MAIN

IF "%~1"=="clearlogs" goto CLEARLOGS
IF "%~1"=="viewlogs" goto VIEWLOGS
IF "%~1"=="fetchlogs" goto FETCHLOGS
IF "%~1"=="fetchscreenshots" goto FETCHSCREENSHOTS
IF "%~1"=="fetchscreenrecords" goto FETCHSCREENRECORDS
IF "%~1"=="fetchlogsandscreenshots" goto FETCHLOGSANDSCREENSHOTS
IF "%~1"=="fetchlogsandscreenrecords" goto FETCHLOGSANDSCREEENRECORDS
IF "%~1"=="deviceproperties" goto DEVICEPROPERTIES
IF "%~1"=="fetchdeviceproperties" goto FETCHDEVICEPROPERTIES
IF "%~1"=="devicecount" goto DEVICECOUNT
IF "%~1"=="cleardata" goto CLEARDATA
IF "%~1"=="force-stop" goto FORCESTOP

:MAIN
SETLOCAL EnableDelayedExpansion

:: Display a list of commands.
echo A list of commands provided by ThibTools:
echo =========================================
call :ECHOCMD "%SPACING%clearlogs"
echo Clear logs of all connected devices.
echo[
call :ECHOCMD "%SPACING%viewlogs"				
echo View logs of all connected devices simultaneously.
echo[
call :ECHOCMD "%SPACING%fetchlogs"				
echo Fetch logs of all connected devices.
echo[
call :ECHOCMD "%SPACING%fetchscreenshots"			
echo Fetch screenshots of all connected devices.
echo[
call :ECHOCMD "%SPACING%fetchscreenrecords"		
echo Fetch screen records of all connected devices.
echo[
call :ECHOCMD "%SPACING%fetchlogsandscreenshots"			
echo Fetch logs and screenshots of all connected devices.
echo[
call :ECHOCMD "%SPACING%fetchlogsandscreenrecords"		
echo Fetch logs and screen records of all connected devices.
echo[
call :ECHOCMD "%SPACING%deviceproperties"			
echo Show device properties.
echo [-s ^<serialNo^>] 			Show properties only for specific device.
echo [-s ^<serialNo^> ^<simpleCommand^>] 	Show property given in simpleCommand for specific device.
echo[
call :ECHOCMD "%SPACING%fetchdeviceproperties"			
echo Fetch device properties of all connected devices.
echo[
call :ECHOCMD "%SPACING%devicecount"			
echo Display the amounts of attached devices and emulators.
echo [-d] devices
echo [-e] emulators
echo[
call :ECHOCMD "%SPACING%cleardata"
echo Clear all data associated with a package.
echo [-s ^<serialNo^>] ^<package^>		Clear package data only for specific device.
echo[
call :ECHOCMD "%SPACING%force-stop"
echo Force-stop a package.
echo [-s ^<serialNo^>] ^<package^>		Force-stop package only on specific device.

echo[
goto :EOF

:CLEARLOGS
call :ECHOCMD "%SPACING%clearlogs"
echo Clear logs of all connected devices.
goto :EOF

:VIEWLOGS
call :ECHOCMD "%SPACING%viewlogs"				
echo View logs of all connected devices simultaneously.
goto :EOF

:FETCHLOGS
call :ECHOCMD "%SPACING%fetchlogs"				
echo Fetch logs of all connected devices.
goto :EOF

:FETCHSCREENSHOTS
call :ECHOCMD "%SPACING%fetchscreenshots"			
echo Fetch screenshots of all connected devices.
goto :EOF

:FETCHSCREENRECORDS
call :ECHOCMD "%SPACING%fetchscreenrecords"		
echo Fetch screen records of all connected devices.
goto :EOF

:FETCHLOGSANDSCREENSHOTS
call :ECHOCMD "%SPACING%fetchlogsandscreenshots"			
echo Fetch logs and screenshots of all connected devices.
goto :EOF

:FETCHLOGSANDSCREEENRECORDS
call :ECHOCMD "%SPACING%fetchlogsandscreenrecords"		
echo Fetch logs and screen records of all connected devices.
goto :EOF

:DEVICEPROPERTIES
call :ECHOCMD "%SPACING%deviceproperties"	
echo Show device properties.
echo [-s ^<serialNo^>] 			Show properties only for specific device.
echo [-s ^<serialNo^> ^<simpleCommand^>] 	Show property given in simpleCommand for specific device.
echo[
echo %SPACING%Simple commands:
echo brand					Brand
echo device					ROM
echo model					Model
echo name					Name
echo manufacturer				Manufacturer
echo serialno				Serial number
echo network					Supported network
echo operator				Operator
echo language				Set language
echo country					Set country
echo carrier					Carrier
echo roaming					Data roaming on/off
echo dateformat				Date format
echo builddate				Build date
echo sdk					API Level

goto :EOF

:FETCHDEVICEPROPERTIES
call :ECHOCMD "%SPACING%fetchdeviceproperties"			
echo Fetch device properties of all connected devices.
goto :EOF

:DEVICECOUNT
call :ECHOCMD "%SPACING%devicecount"
echo Display the amounts of attached devices and emulators
echo [-d] devices
echo [-e] emulators
goto :EOF

:CLEARDATA
call :ECHOCMD "%SPACING%cleardata"
echo Clear all data associated with a package.
echo [-s ^<serialNo^>] ^<package^>		Clear package data only for specific device.
goto :EOF

:FORCESTOP
call :ECHOCMD "%SPACING%force-stop"
echo Force-stop a package.
echo [-s ^<serialNo^>] ^<package^>		Force-stop package only on specific device.
goto :EOF

:ECHOCMD
:: Set the title color
SET COL=0f
echo %DEL% > "%~1"
findstr /v /a:%COL% /R "^$" "%~1" nul
del "%~1" > nul 2>&1
goto :EOF