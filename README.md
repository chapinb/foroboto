Foroboto
======

**ADB Acquisition Tool for Android Forensics**

*Copyright (C) 2014, Chapin Bryce*

# Installation & Dependencies

Place the `adb.exe`, `AdbWinApi.dll`, and `AdbWinUsbApi.dll` in the same directory of the `foroboto.bat` script. These dependencies can be downloaded from [Google's SDK Site](http://developer.android.com/sdk/index.html). Be sure to locate the `adb.exe` and either copy the noted dependencies into the same directory as `foroboto.bat` or copy `foroboto.bat` into the directory containing `adb.exe` 

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
