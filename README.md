Foroboto
======

**ADB Acquisition Tool for Android Forensics**

*Copyright (C) 2014, Chapin Bryce*

# About the tool

This tool automates the acquisition of Android Devices via ADB. The following collection levels are available;


     [USER] Select the run level you wish to execute:
     1. Collect live information (Dumpstate + Logcat)
     2. Level 1 + System information
     3. Level 2 + Logical acquisition of the SD Card
     4. Level 3 + Logical acquisition of the Data directory
     5. Level 4 + Full logical acuisition (Common local directories)
     Type in the collection level (1-5):


# Installation & Dependencies

## Windows

Place the `adb.exe`, `AdbWinApi.dll`, and `AdbWinUsbApi.dll` in the same directory of the `foroboto.bat` script. These dependencies can be downloaded from [Google's SDK Site](http://developer.android.com/sdk/index.html). Be sure to locate the `adb.exe` and either copy the noted dependencies into the same directory as `foroboto.bat` or copy `foroboto.bat` into the directory containing `adb.exe` 

## Unix

Place the `adb` file in the same directory as `foroboto.sh`. You may also copy the `foroboto.sh` script into the directory with `adb`. For consistancy reasons, adb will not run from `/bin/` unless the `foroboto.sh` script is also located in that directory.

# Usage

* Android must be plugged in and have ADB USB Debugging Enabled
* For Level 4 and 5 Acquisition, root access is required
  * The script will attempt to escilate to root by default
* Device must be authenticated by device for connection

## Windows Batch Script [.bat]

Run `foroboto.bat` 

## Unix Bash Script [.sh]

Run `./foroboto.sh` 

# More Information

Visit the project's development page on GitHub: https://github.com/chapinb/foroboto
Leave any feature requests or bugs found in the issues tab.
Wiki page coming soon!

Tested on Windows 7 and OSX 10.8 against a Nexus 7 2013
