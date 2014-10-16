rem    ADB Acquisition and processing script
rem    Copyright (C) 2014 Chapin Bryce
rem	   You can find more code at github.com/chapinb
rem
rem    This program is free software: you can redistribute it and/or modify
rem    it under the terms of the GNU General Public License as published by
rem    the Free Software Foundation, either version 3 of the License, or
rem    (at your option) any later version.
rem
rem    This program is distributed in the hope that it will be useful,
rem    but WITHOUT ANY WARRANTY; without even the implied warranty of
rem    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
rem    GNU General Public License for more details.
rem
rem    You should have received a copy of the GNU General Public License
rem    along with this program.  If not, see <http://www.gnu.org/licenses/>.

rem Version 20141002

rem Prompt user for Report Information
@ECHO off
ECHO [INFO] Starting Roboto...
:err1
cls
set /p RPTNUM=Type in report # (i.e. 9999):
ECHO You typed: "%RPTNUM%"
set/p _RNV=Is this correct? (y/n)
If /i "%_RNV%"=="n" goto :err1
cls

rem Prompt user for ADB Location [Depreciated]
rem :err2
rem ECHO [USER] Select adb.exe location
rem vset /p ADBPATH=Type in the full path to adb.exe ("C:\adt\adb.exe"):
rem echo You specified "%ADBPATH%"
rem set /p _CLV=Is this correct? (y/n)
rem If /i "%_CLV%"=="n" goto :err2
rem if exist {%ADBPATH%} (
	rem file exists
rem ) else ( 
rem	echo Invalid path, try again
rem	goto :err2

rem cls

SET _ADBPATH=adb.exe


rem Prompt user for run level
:err3
cls
ECHO [USER] Select the run level you wish to execute:
ECHO 	1. Collect live information (Dumpstate + Logcat)
ECHO 	2. Level 1 + System information 
ECHO 	3. Level 2 + Logical acquisition of the SD Card
ECHO 	4. Level 3 + Logical acquisition of the Data directory
ECHO 	5. Level 4 + Full logical acquisition (All local directories)
set /p COLLVL=Type in the collection level (1-5):
echo You selected level "%COLLVL%"
set /p _CLV=Is this correct? (y/n)
If /i "%_CLV%"=="n" goto :err3
cls

rem Make directory to output to
mkdir %RPTNUM%

rem Check ADB devices
:err4
echo [USER] Ensure the android device is connected and ADB Debugging is enabled on the device.
set Press enter to check for connected ADB Devices
%_ADBPATH% devices
set /p _CHK=Is the correct device connected? (y/n)
If /i "%_CHK%"=="n" goto :err4
set /p _CHKROOT=Would you like to escalate to root using `adb root` [see README for more details] (y/n):
If /i "%_CHKROOT%"=="y" _ADBPATH% root
cls

ECHO **************************************************
ECHO **************************************************
echo This collection is starting
echo This may take a few minutes
ECHO **************************************************
ECHO **************************************************

rem Start processing Level 1

echo [INFO] Running dumpstate
%_ADBPATH% shell dumpstate > %RPTNUM%/dumpstate.txt

echo [INFO] Running logcat
%_ADBPATH% shell logcat -d -v long V:* > %RPTNUM%/logcat.txt


rem Go to run level
If /i "%COLLVL%"=="1" goto :lvl1 
If /i "%COLLVL%"=="2" goto :lvl2
mkdir %RPTNUM%\fs-pull
If /i "%COLLVL%"=="3" goto :lvl3
If /i "%COLLVL%"=="4" goto :lvl4
If /i "%COLLVL%"=="5" goto :lvl5


rem Start processing Level 5
:lvl5

echo [INFO] Acquiring Acct Directory
mkdir %RPTNUM%\fs-pull\acct
%_ADBPATH% pull /acct/ %RPTNUM%/fs-pull/acct/ >> %RPTNUM%/fs-pull.log.txt  2>&1

echo [INFO] Acquiring Cache Directory
mkdir %RPTNUM%\fs-pull\cache
%_ADBPATH% pull /cache/ %RPTNUM%/fs-pull/cache/ >> %RPTNUM%/fs-pull.log.txt  2>&1

echo [INFO] Acquiring Charger Directory
mkdir %RPTNUM%\fs-pull\charger
%_ADBPATH% pull /charger/ %RPTNUM%/fs-pull/charger/ >> %RPTNUM%/fs-pull.log.txt  2>&1

echo [INFO] Acquiring Config Directory
mkdir %RPTNUM%\fs-pull\config
%_ADBPATH% pull /config/ %RPTNUM%/fs-pull/config/ >> %RPTNUM%/fs-pull.log.txt  2>&1

echo [INFO] Acquiring d Directory
mkdir %RPTNUM%\fs-pull\d
%_ADBPATH% pull /d/ %RPTNUM%/fs-pull/d/ >> %RPTNUM%/fs-pull.log.txt  2>&1

echo [INFO] Acquiring Etc Directory
mkdir %RPTNUM%\fs-pull\etc
%_ADBPATH% pull /etc/ %RPTNUM%/fs-pull/etc/ >> %RPTNUM%/fs-pull.log.txt  2>&1

echo [INFO] Acquiring Mnt Directory
mkdir %RPTNUM%\fs-pull\mnt
%_ADBPATH% pull /mnt/ %RPTNUM%/fs-pull/mnt/ >> %RPTNUM%/fs-pull.log.txt  2>&1

echo [INFO] Acquiring Res Directory
mkdir %RPTNUM%\fs-pull\res
%_ADBPATH% pull /res/ %RPTNUM%/fs-pull/res/ >> %RPTNUM%/fs-pull.log.txt  2>&1

echo [INFO] Acquiring Root Directory
mkdir %RPTNUM%\fs-pull\root
%_ADBPATH% pull /root/ %RPTNUM%/fs-pull/root/ >> %RPTNUM%/fs-pull.log.txt  2>&1

echo [INFO] Acquiring SBin Directory
mkdir %RPTNUM%\fs-pull\sbin
%_ADBPATH% pull /sbin/ %RPTNUM%/fs-pull/sbin/ >> %RPTNUM%/fs-pull.log.txt  2>&1

echo [INFO] Acquiring Sys Directory
mkdir %RPTNUM%\fs-pull\sys
%_ADBPATH% pull /sys/ %RPTNUM%/fs-pull/sys/ >> %RPTNUM%/fs-pull.log.txt  2>&1

echo [INFO] Acquiring System Directory
mkdir %RPTNUM%\fs-pull\system
%_ADBPATH% pull /system/ %RPTNUM%/fs-pull/system/ >> %RPTNUM%/fs-pull.log.txt  2>&1

echo [INFO] Acquiring Tombstones Directory
mkdir %RPTNUM%\fs-pull\tombstones
%_ADBPATH% pull /tombstones/ %RPTNUM%/fs-pull/tombstones/ >> %RPTNUM%/fs-pull.log.txt  2>&1

rem Add back in later. way too time consuming
rem echo [INFO] Acquiring Proc Directory
rem mkdir %RPTNUM%\fs-pull\proc
rem %_ADBPATH% pull /proc/ %RPTNUM%/fs-pull/proc/ >> %RPTNUM%/fs-pull.log.txt  2>&1

rem Start processing Level 4
:lvl4

echo [INFO] Acquiring Data Directory
mkdir %RPTNUM%\fs-pull\d
%_ADBPATH% pull /data/ %RPTNUM%/fs-pull/data/ >> %RPTNUM%/fs-pull.log.txt  2>&1

rem Start processing Level 3
:lvl3

echo [INFO] Acquiring SD Card
mkdir %RPTNUM%\fs-pull\sdcard
%_ADBPATH% pull /sdcard/ %RPTNUM%/fs-pull/sdcard/ >> %RPTNUM%/fs-pull.log.txt  2>&1

rem Start processing Level 2
:lvl2

echo [INFO] Running mount
%_ADBPATH% shell mount > %RPTNUM%/mount.txt

echo [INFO] Running netstat
%_ADBPATH% shell netstat > %RPTNUM%/netstat.txt

echo [INFO] Running netcfg
%_ADBPATH% shell netcfg > %RPTNUM%/netcfg.txt

echo [INFO] Running ifconfig
%_ADBPATH% shell ifconfig > %RPTNUM%/ifconfig.txt

echo [INFO] Running date
%_ADBPATH% shell date > %RPTNUM%/date.txt

echo [INFO] Running df
%_ADBPATH% shell df > %RPTNUM%/df.txt

echo [INFO] Running lsof
%_ADBPATH% shell lsof > %RPTNUM%/lsof.txt

echo [INFO] Running uptime
%_ADBPATH% shell uptime > %RPTNUM%/uptime.txt

:lvl1
echo [INFO] Completed %RPTNUM%
