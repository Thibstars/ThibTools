@echo off
TITLE ThibTools 1.0 - By Thibault Helsmoortel

echo Welcome to ThibTools.
echo ThibTools provides you with a set of commands to simplify your Android testing with adb.
echo ========================================================================================

echo Type 'help' to view a list of useful commands.
echo[

:THIBTOOLS
:: Open cmd in the ThibTools directory. Use the commands from here.
cd /d %~dp0 
cmd /k
:: Make sure adb is running
call adb start-server

nopause