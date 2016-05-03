@echo off
echo Opening log window(s)...
@call ADB+P "logcat -v time logcat mono-stdout:D  Mono:D AndroidRuntime:E AppTracker:D *:S" > nul
echo Ready!
