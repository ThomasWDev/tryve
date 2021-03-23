# Tryve

## How to run Tryve

1 . Clone by typing `git clone https://github.com/ThomasWDev/tryve.git` on terminal / CMD
2 . Type `cd tryve_flutter`/Users/thomaswoodfin/Documents/TRVE/tryve_flutter

## Install flutter if you don't have flutter installed

1 . Go to [this](https://flutter.dev/docs/get-started/install) Url .
If updating, go to https://flutter.dev/docs/development/tools/sdk/upgrading

2 . Click on the respective platform and download flutter-*.zip

3 . Download (2.0.3) version

4 . Extract the zip file and copy that folder to your desired destination

5 . Navigate to the extracted folder and type in `export PATH="$PATH:`pwd`/flutter/bin"` , it will add flutter to your path

6 . Make sure you have java installed on your computer . Check by typing `java -version` . Recommended to use version "1.0.8" or Java SDK 8

7 . Make sure you have `ANDROID_HOME` and `ANDROID_SDK_ROOT` variables setup , if you don't copy the Android SDK path and paste it inside your bash profile , for windows add to the path registry by doing this :
i) `export ANDROID_HOME="/Users/YOURNAME/Library/Android/sdk"`
ii) `export ANDROID_SDK_ROOT="$ANDROID_HOME"`
iii) `export PATH=${PATH}:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools`

8 . Run `flutter doctor -v`

9 . Accept all of the licenses for android by typing `flutter doctor --android-licenses`

10 . Run `flutter doctor` again to see if everything is working .

11 . Navigate to the `tryve_flutter` folder and run the app by `flutter run` , for verbose add in the `--verbose` flag
