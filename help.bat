@echo off

for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set "DEL=%%a"
)

SET "SPACING=               "

IF "%~1" == "" goto MAIN

IF "%~1"=="clearlogs" call :CLEARLOGS 1
IF "%~1"=="viewlogs" call :VIEWLOGS 1
IF "%~1"=="fetchlogs" call :FETCHLOGS 1
IF "%~1"=="fetchscreenshots" call :FETCHSCREENSHOTS 1
IF "%~1"=="fetchscreenrecords" call :FETCHSCREENRECORDS 1
IF "%~1"=="fetchlogsandscreenshots" call :FETCHLOGSANDSCREENSHOTS 1
IF "%~1"=="fetchlogsandscreenrecords" call :FETCHLOGSANDSCREEENRECORDS 1
IF "%~1"=="deviceproperties" call :DEVICEPROPERTIES 1
IF "%~1"=="fetchdeviceproperties" call :FETCHDEVICEPROPERTIES 1
IF "%~1"=="devicecount" call :DEVICECOUNT 1
IF "%~1"=="cleardata" call :CLEARDATA 1
IF "%~1"=="force-stop" call :FORCESTOP 1
IF "%~1"=="launch" call :LAUNCH 1
IF "%~1"=="packages" call :PACKAGES 1
IF "%~1"=="printpath" call :PRINTPATH 1
IF "%~1"=="netstat" call :NETSTAT 1
IF "%~1"=="battery" call :BATTERY 1
IF "%~1"=="bugreport" call :BUGREPORT 1
IF "%~1"=="threads" call :THREADS 1
goto :EOF


:MAIN
SETLOCAL EnableDelayedExpansion

:: Display a list of commands.
echo A list of commands provided by ThibTools:
echo =========================================
call :BATTERY
call :BUGREPORT
call :CLEARDATA
call :CLEARLOGS
call :DEVICECOUNT
call :DEVICEPROPERTIES
call :FETCHDEVICEPROPERTIES
call :FETCHLOGS
call :FETCHLOGSANDSCREENSHOTS
call :FETCHLOGSANDSCREEENRECORDS
call :FETCHSCREENSHOTS
call :FETCHSCREENRECORDS
call :FORCESTOP
call :LAUNCH
call :NETSTAT
call :PACKAGES
call :PRINTPATH
call :THREADS
call :VIEWLOGS

goto :EOF

:CLEARLOGS
call :ECHOCMD "%SPACING%clearlogs"
echo Clear logs of all connected devices.
echo[
goto :EOF

:VIEWLOGS
call :ECHOCMD "%SPACING%viewlogs"				
echo View logs of all connected devices simultaneously.
echo[
goto :EOF

:FETCHLOGS
call :ECHOCMD "%SPACING%fetchlogs"				
echo Fetch logs of all connected devices.
echo[
goto :EOF

:FETCHSCREENSHOTS
call :ECHOCMD "%SPACING%fetchscreenshots"			
echo Fetch screenshots of all connected devices.
echo[
goto :EOF

:FETCHSCREENRECORDS
call :ECHOCMD "%SPACING%fetchscreenrecords"		
echo Fetch screen records of all connected devices.
echo[
goto :EOF

:FETCHLOGSANDSCREENSHOTS
call :ECHOCMD "%SPACING%fetchlogsandscreenshots"			
echo Fetch logs and screenshots of all connected devices.
echo[
goto :EOF

:FETCHLOGSANDSCREEENRECORDS
call :ECHOCMD "%SPACING%fetchlogsandscreenrecords"		
echo Fetch logs and screen records of all connected devices.
echo[
goto :EOF

:DEVICEPROPERTIES
call :ECHOCMD "%SPACING%deviceproperties"	
echo Show device properties.
echo ^<simpleCommand^|property^>		Show property given in simpleCommand or property for all devices.
echo [-s ^<serialNo^>] 			Show properties only for specific device.
echo [-s ^<serialNo^> ^<simpleCommand^|property^>]Show property given in simpleCommand or property for specific device.
echo[
:: The extended version includes:
IF "%~1"=="" goto :EOF
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
echo[
goto :EOF

:FETCHDEVICEPROPERTIES
call :ECHOCMD "%SPACING%fetchdeviceproperties"			
echo Fetch device properties of all connected devices.
echo[
goto :EOF

:DEVICECOUNT
call :ECHOCMD "%SPACING%devicecount"
echo Display the amounts of attached devices and emulators
echo [-d] devices
echo [-e] emulators
echo[
goto :EOF

:CLEARDATA
call :ECHOCMD "%SPACING%cleardata"
echo Clear all data associated with a package.
echo [-s ^<serialNo^>] ^<package^>		Clear package data only for specific device.
echo[
goto :EOF

:FORCESTOP
call :ECHOCMD "%SPACING%force-stop"
echo Force-stop an app.
echo ^<package^>				Force-stop app on all devices.
echo [-s ^<serialNo^>] ^<package^>		Force-stop app only on specific device.
echo[
goto :EOF

:LAUNCH
call :ECHOCMD "%SPACING%launch"
echo Launch an app.
echo [-s ^<serialNo^>] ^<package^>		Launch app only on specific device.
echo[
goto :EOF

:PACKAGES
call :ECHOCMD "%SPACING%packages"
echo List packages.
echo [-s ^<serialNo^>] [-f] ^<filter^>		See their associated file.		
echo [-s ^<serialNo^>] [-d] ^<filter^>		Filter only disabled packages.
echo [-s ^<serialNo^>] [-e] ^<filter^>		Filter only enabled packages.
echo [-s ^<serialNo^>] [-3] ^<filter^>		Filter only system packages.
echo [-s ^<serialNo^>] [-i] ^<filter^>		Filter only third party packages.
echo [-s ^<serialNo^>] [-u] ^<filter^>		See their installer.
echo [-s ^<serialNo^>] [--user] ^<USER_ID^>	The user space to query.
echo[
goto :EOF

:PRINTPATH
call :ECHOCMD "%SPACING%printpath"
echo Print the path to the APK of the given package.
echo ^<package^>				Print the path on all devies.
echo [-s ^<serialNo^>] ^<package^>		Print the path only on specific devices.
echo[
goto :EOF

:NETSTAT
call :ECHOCMD "%SPACING%netstat"
echo Display network statistics.
echo [-s ^<serialNo^>] 			Display network statistics only for specific device.
echo[
goto :EOF

:BATTERY
call :ECHOCMD "%SPACING%battery"
echo Display battery information.
echo [-s ^<serialNo^>]				Display battery info only for specific device.
echo[
goto :EOF

:BUGREPORT
call :ECHOCMD "%SPACING%bugreport"
echo Creates bug reports and saves them to files.
echo[
goto :EOF

:THREADS
call :ECHOCMD "%SPACING%threads"
echo Lists the active top threads.
echo ^<package^>				List threads of a package.
echo [-s ^<serialNo^>] ^<package^>		Display threads only for specific device.
echo[
goto :EOF

:ECHOCMD
:: Set the title color
SET COL=0f
echo %DEL% > "%~1"
findstr /v /a:%COL% /R "^$" "%~1" nul
del "%~1" > nul 2>&1
goto :EOF