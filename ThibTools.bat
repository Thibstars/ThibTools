@echo off
TITLE ThibTools 1.0 - By Thibault Helsmoortel

echo Welcome to ThibTools.
echo ThibTools provides you with a set of commands to simplify your Android testing with adb.
echo ========================================================================================

:: Display a list of commands.
echo A list of commands provided by ThibTools:
echo clearlogs				clears all device logs
echo viewlogs				view logs of all connected devices simultaneously
echo fetchlogs				fetch logs of all connected devices
echo fetchscreenshots			fetch screenshots of all connected devices
echo fetchscreenrecords			fetch screen records of all connected devices
echo fetchlogsandscreenshots			fetch logs and screenshots of all connected devices
echo fetchlogsandscreenrecords		fetch logs and screen records of all connected devices
pause
goto THIBTOOLS

:THIBTOOLS
:: Open cmd in the ThibTools directory. Use the commands from here.
cls
echo ThibTools Started... You can now use the provided commands.
cd /d %~dp0
cmd.exe 

nopause