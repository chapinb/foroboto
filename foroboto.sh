#    ADB Acquisition and processing script
#    Copyright (C) 2014 Chapin Bryce
#	   You can find more code at github.com/chapinb
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.

# Version 20141002

#########################################
## Functions
#########################################
# Start processing Level 5
function lvl5 {

	echo [INFO] Acquiring Acct Directory
	mkdir $CASENAME/fs-pull/acct
	$_ADBPATH pull /acct/ $CASENAME/fs-pull/acct/ >> $CASENAME/fs-pull.log.txt  2>&1

	echo [INFO] Acquiring Cache Directory
	mkdir $CASENAME/fs-pull/cache
	$_ADBPATH pull /cache/ $CASENAME/fs-pull/cache/ >> $CASENAME/fs-pull.log.txt  2>&1

	echo [INFO] Acquiring Charger Directory
	mkdir $CASENAME/fs-pull/charger
	$_ADBPATH pull /charger/ $CASENAME/fs-pull/charger/ >> $CASENAME/fs-pull.log.txt  2>&1

	echo [INFO] Acquiring Config Directory
	mkdir $CASENAME/fs-pull/config
	$_ADBPATH pull /config/ $CASENAME/fs-pull/config/ >> $CASENAME/fs-pull.log.txt  2>&1

	echo [INFO] Acquiring d Directory
	mkdir $CASENAME/fs-pull/d
	$_ADBPATH pull /d/ $CASENAME/fs-pull/d/ >> $CASENAME/fs-pull.log.txt  2>&1

	echo [INFO] Acquiring Etc Directory
	mkdir $CASENAME/fs-pull/etc
	$_ADBPATH pull /etc/ $CASENAME/fs-pull/etc/ >> $CASENAME/fs-pull.log.txt  2>&1

	echo [INFO] Acquiring Mnt Directory
	mkdir $CASENAME/fs-pull/mnt
	$_ADBPATH pull /mnt/ $CASENAME/fs-pull/mnt/ >> $CASENAME/fs-pull.log.txt  2>&1

	echo [INFO] Acquiring Res Directory
	mkdir $CASENAME/fs-pull/res
	$_ADBPATH pull /res/ $CASENAME/fs-pull/res/ >> $CASENAME/fs-pull.log.txt  2>&1

	echo [INFO] Acquiring Root Directory
	mkdir $CASENAME/fs-pull/root
	$_ADBPATH pull /root/ $CASENAME/fs-pull/root/ >> $CASENAME/fs-pull.log.txt  2>&1

	echo [INFO] Acquiring SBin Directory
	mkdir $CASENAME/fs-pull/sbin
	$_ADBPATH pull /sbin/ $CASENAME/fs-pull/sbin/ >> $CASENAME/fs-pull.log.txt  2>&1

	echo [INFO] Acquiring Sys Directory
	mkdir $CASENAME/fs-pull/sys
	$_ADBPATH pull /sys/ $CASENAME/fs-pull/sys/ >> $CASENAME/fs-pull.log.txt  2>&1

	echo [INFO] Acquiring System Directory
	mkdir $CASENAME/fs-pull/system
	$_ADBPATH pull /system/ $CASENAME/fs-pull/system/ >> $CASENAME/fs-pull.log.txt  2>&1

	echo [INFO] Acquiring Tombstones Directory
	mkdir $CASENAME/fs-pull/tombstones
	$_ADBPATH pull /tombstones/ $CASENAME/fs-pull/tombstones/ >> $CASENAME/fs-pull.log.txt  2>&1

	#Add in later - too time consuming
	#echo [INFO] Acquiring Proc Directory
	#mkdir $CASENAME/fs-pull/proc
	#$_ADBPATH pull /proc/ $CASENAME/fs-pull/proc/ >> $CASENAME/fs-pull.log.txt  2>&1


}

# Start processing Level 4
function lvl4 {

	echo [INFO] Acquiring Data Directory
	mkdir $CASENAME/fs-pull/d
	$_ADBPATH pull /data/ $CASENAME/fs-pull/data/ >> $CASENAME/fs-pull.log.txt  2>&1
}
 
# Start processing Level 3
function lvl3 {
	echo [INFO] Acquiring SD Card
	mkdir $CASENAME/fs-pull/sdcard
	$_ADBPATH pull /sdcard/ $CASENAME/fs-pull/sdcard/ >> $CASENAME/fs-pull.log.txt  2>&1
}

# Start processing Level 2
function lvl2 {
	echo [INFO] Running mount
	$_ADBPATH shell mount > $CASENAME/mount.txt

	echo [INFO] Running netstat
	$_ADBPATH shell netstat > $CASENAME/netstat.txt

	echo [INFO] Running netcfg
	$_ADBPATH shell netcfg > $CASENAME/netcfg.txt

	echo [INFO] Running ifconfig
	$_ADBPATH shell ifconfig > $CASENAME/ifconfig.txt

	echo [INFO] Running date
	$_ADBPATH shell date > $CASENAME/date.txt

	echo [INFO] Running df
	$_ADBPATH shell df > $CASENAME/df.txt

	echo [INFO] Running lsof
	$_ADBPATH shell lsof > $CASENAME/lsof.txt

	echo [INFO] Running uptime
	$_ADBPATH shell uptime > $CASENAME/uptime.txt
}

# Start processing Level 1
function lvl1 {
	echo [INFO] Running dumpstate
	$_ADBPATH shell dumpstate > $CASENAME/dumpstate.txt

	echo [INFO] Running logcat
	$_ADBPATH shell logcat -d -v long V:* > $CASENAME/logcat.txt
}

#########################################
## End Functions
#########################################

# Prompt user for Report Information
set +v
echo [INFO] Starting Roboto...

clear
echo "Type in report # (i.e. 9999):"
read CASENAME
echo You typed: $CASENAME
clear

# Prompt user for ADB Location [Depreciated]
# echo [USER] Select adb.exe location
# vset /p ADBPATH=Type in the full path to adb.exe ("C:/adt/adb.exe"):
# echo You specified "$ADBPATH"
# set /p _CLV=Is this correct? (y/n)
# If /i "$_CLV"=="n" goto :err2
# if exist {$ADBPATH} (
	# file exists
# ) else ( 
#	echo Invalid path, try again
#	goto :err2

# clear

_ADBPATH=./adb


# Prompt user for run level
clear
echo [USER] Select the run level you wish to execute:
echo "1. Collect live information (Dumpstate + Logcat)"
echo "2. Level 1 + System information"
echo "3. Level 2 + Logical acquisition of the SD Card"
echo "4. Level 3 + Logical acquisition of the Data directory"
echo "5. Level 4 + Full logical acquisition (Common local directories)"
echo "Type in the collection level (1-5):"
read COLLVL
echo You selected level $COLLVL
clear

# Make directory to output to
mkdir $CASENAME

# Check ADB devices
echo [USER] Ensure the android device is connected and ADB Debugging is enabled on the device.

$_ADBPATH devices

echo "Would you like to escalate to root using `adb root` [see README for more details] (y/n):"
read RUNROOT
if [ "$RUNROOT" == y ]; then 
	$_ADBPATH root
fi

clear

echo "**************************************************
**************************************************
This collection is starting
This may take a few minutes
**************************************************
**************************************************"


# Go to run level
if [ "$COLLVL" == 1 ]; then 
	lvl1

elif [ "$COLLVL" == 2 ]; then 
	lvl1
	mkdir $CASENAME/fs-pull
	lvl2

elif [ "$COLLVL" == 3 ]; then 
	lvl1
	mkdir $CASENAME/fs-pull
	lvl2
	lvl3

elif [ "$COLLVL" == 4 ]; then 
	lvl1
	mkdir $CASENAME/fs-pull
	lvl2
	lvl3
	lvl4

elif [ "$COLLVL" == 5 ]; then 
	lvl1
	mkdir $CASENAME/fs-pull
	lvl2
	lvl3
	lvl4
	lvl5
else
  echo "Invalid Run Level: " $COLLVL
fi



echo "[INFO] Completed $CASENAME"
