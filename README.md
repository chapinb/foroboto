Foroboto
======

**ADB Acquisition Tool for Android Forensics**

*Copyright (C) 2014, Chapin Bryce*

# About the tool

This tool automates the acquisition of Android Devices via ADB using Windows or Unix based workstations. 

The following collection levels are available at this time:


     [USER] Select the run level you wish to execute:
     1. Collect live information (Dumpstate + Logcat)
     2. Level 1 + System information
     3. Level 2 + Logical acquisition of the SD Card
     4. Level 3 + Logical acquisition of the Data directory
     5. Level 4 + Full logical acquisition (Common local directories)
     Type in the collection level (1-5):


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
