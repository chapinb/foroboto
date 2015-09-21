Foroboto
======

**ADB Acquisition Tool for Android Forensics**

*Copyright (C) 2014, Chapin Bryce*

# About the tool

This tool automates the acquisition of Android Devices via ADB using Windows or Unix based workstations. 

Please note active issues prior to use on cases. Intended for development and testing purposes only.

The following collection levels are available at this time:


     [USER] Select the run level you wish to execute:
     1. Collect live information (Dumpstate + Logcat)
     2. Level 1 + System information
     3. Level 2 + Logical acquisition of the SD Card
     4. Level 3 + Logical acquisition of the Data directory
     5. Level 4 + Full logical acquisition (Common local directories)
     Type in the collection level (1-5):


Each level specifies a new stage of tasks. Since each level builds on the previous, the commands are inclusive. In example, selecting level 3 will also run the commands in level 2 and level 1, but not the higher levels such as 4 or 5. 

### Level 1

- What it runs:
  - Dumpstate
  - Logcat
- What this information means:
  - This collections provides the most information possible in the shortest time. Though designed to provide information to developers debugging applications, it provides detailed information about a device for an examiner.
- Is root access required:
  - No.
 
### Level 2

- What it runs:
  - Mount Points
  - Network Connections
  - Date and Time information
  - Storage Device Usage
  - List of Open Files
  - Amount of time the device has been running
- What this information means:
  - This is the next stage and provides supporting information to allow the examiner to see additional information about networking and storage information.
- Is root access required:
  - No, but will provide more information about what files are open if available
  
### Level 3

- What it runs:
  - Copy SD Card data out of the device
- What this information means:
  - This will capture all data that is accessible with the current permissions.  
- Is root access required:
  - No, but more files can be captured with root accessed

### Level 4

- What it runs:
  - Copy entries from /data/
- What this information means:
  - This is where most of the configuration and application data is stored. 
  - There have been reported errors associated with the acquisition of all information within /data/data. Will be solved in future
- Is root access required:
  - Yes

### Level 5

- What it runs:
  - Gathers data from the following directories:
    - /cache
	- /charger
	- /config
	- /d
	- /etc
	- /mnt
	- /res
	- /root
	- /sbin
	- /sys
	- /system
	- /tombstones
- What this information means:
  - This attempts to gather all information from the common directories on the device. 
- Is root access required:
  - Yes

# Installation & Dependencies

## Windows

Place the `adb.exe`, `AdbWinApi.dll`, and `AdbWinUsbApi.dll` in the same directory of the `foroboto.bat` script. These dependencies can be downloaded from [Google's SDK Site](http://developer.android.com/sdk/index.html). Be sure to locate the `adb.exe` and either copy the noted dependencies into the same directory as `foroboto.bat` or copy `foroboto.bat` into the directory containing `adb.exe` 

## Unix

Place the `adb` file in the same directory as `foroboto.sh`. You may also copy the `foroboto.sh` script into the directory with `adb`. For consistancy reasons, adb will not run from `/bin/` unless the `foroboto.sh` script is also located in that directory.

# Usage

* Android must be plugged in and have ADB USB Debugging Enabled
  * Device may be connected over a TCPIP connection or USB cable.
* For Level 4 and 5 Acquisition, root access is required
  * The user will be prompted to escilate root on the dvice using `adb root`.
* Root escilation will only work with devices that can handle the `adb root` command.
  * Some root methods, such as TowelRoot, do not tolerate this method and may disconnect the device after refusing root
* Device must be authenticated by device for connection

## Connecting with ADB

* With a USB cable connect the tablet to your machine.
  * Windows has an assortment of driver issues and you may have to update the driver in order to connect the device properly
    * See http://chapinbryce.com/android-driver/ for more information on resolving the driver issues
  * Verify the connection works by running `adb devices`.
* To connect over WiFi, ensure the device and workstation are on the same WiFi subnet, and run the following commands on the Android device
    
	su
	setprop service.adb.tcp.port 5555
	stop adbd
	start adbd
	
  * On your workstation run the following commands (replace the IP 0.0.0.0 with the Android's Ip address)
	
	adb tcpip 5555
	adb connect 0.0.0.0:5555
	adb devices

## Windows Batch Script [.bat]

Run `foroboto.bat` 

## Unix Bash Script [.sh]

Run `./foroboto.sh` 

# More Information

The full blog writeup can be found at http://chapinbryce.com/foroboto-20141002/

Visit the project's development page on GitHub: https://github.com/chapinb/foroboto
Leave any feature requests or bugs found in the issues tab.
Wiki page coming soon!

Tested on Windows 7 and OSX 10.8 against a Nexus 7 2013 running CyanogenMod and Towelroot.
