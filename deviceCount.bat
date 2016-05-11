@echo off

:: Instantiate counters
SET lcd=0
SET lce=0

:: Instantiate search terms
SET dev="device"
SET em="emulator"

IF %1.==. goto MAIN
IF "%1"=="-d" goto DEVCOUNT
IF "%1"=="-e" goto EMCOUNT

SETLOCAL ENABLEDELAYEDEXPANSION 

:MAIN
:: Correctly set the device counter, ignore lines that include "emulator"
adb devices | FIND /V %em% | FIND /I /C %dev% > tmpDev
SET /P lcd= < tmpDev
DEL tmpDEV

:: Correctly set the emulator counter
adb devices | FIND /I /C %em% > tmpEm
SET /P lce= < tmpEm
DEL tmpEM

:: Remove 1 from the count for the "devices" occurrence from the first line
SET /a lcd-=1

:: Display results
echo Attached devices:
echo Devices:   %lcd%
echo Emulators: %lce%
goto END

:DEVCOUNT
:: Correctly set the device counter, ignore lines that include "emulator"
adb devices | FIND /V %em% | FIND /I /C %dev% > tmpDev
SET /P lcd= < tmpDev
DEL tmpDEV

SET /a lcd-=1
echo Attached devices:   %lcd%

goto END

:EMCOUNT
:: Correctly set the emulator counter
adb devices | FIND /I /C %em% > tmpEm
SET /P lce= < tmpEm
DEL tmpEM

echo Attached emulators: %lce%

goto END

:END
ENDLOCAL