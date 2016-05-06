@echo off

:: Display a list of commands.
echo A list of commands provided by ThibTools:
echo =========================================
echo clearlogs			clear logs of all connected devices
echo viewlogs			view logs of all connected devices simultaneously
echo fetchlogs			fetch logs of all connected devices
echo fetchscreenshots		fetch screenshots of all connected devices
echo fetchscreenrecords		fetch screen records of all connected devices
echo fetchlogsandscreenshots		fetch logs and screenshots of all connected devices
echo fetchlogsandscreenrecords	fetch logs and screen records of all connected devices
echo fetchdeviceproperties		fetch device properties of all connected devices
echo deviceproperties [-s ^<serialNo^> ^<simpleCommand^>] 
echo 				show device properties
echo [-s] ^<serialNo^>			show properties only for specific device
echo [-s] ^<serialNo^> ^<simpleCommand^> show property given in simpleCommand for specific device
echo devicecount [-d -e]		display the amounts of attached devices and emulators
echo [-d] devices 
echo [-e] emulators