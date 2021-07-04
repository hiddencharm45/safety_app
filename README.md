# safety_app

Together- Safety App For Women- Final Year Project

## Getting Started

This project is a starting point for a Flutter application.

About- This project aims to provide safety for women, in emergency situations, by sending SOS message to the preselected contacts.

Requirements- In order to run this project we'll need
1) Android SDK
2) Java JDK
3) Flutter Version 1.22.5
4) Dart version 2.10.4
5) Minimum RAM 4GB to run emulator successfully/ or real-device for testing.
6) 3GB of Hard-Disk Space

On-Installing the app, it could run on any android device with version 4.4 and above.

Note: While using firebase for phone authentication we should make sure to generate SHA-1 and SHA-256 keys for our system and register it.
To generate key:
1) Download and install Java SDK (preferably in the default location).


2) Edit environment variables. Set JAVA_HOME to the location of jdk & Path to the location of bin.


3) Open VS Code terminal and check if 'keytool' is available.


4) Generate a key with this command & provide the necessary infos (default password is 'android'):   keytool -genkey -v -keystore c:\Users\USER_NAME\upload-keystore.jks -storetype JKS -keyalg RSA - keysize 2048 -validity 10000 - alias upload



5) Open command prompt & go to jdk bin directory and execute this command: keytool -list -v -keystore c:\Users\Ritu\.android\debug.keystore -alias androiddebugkey -storepass android -keypass android
                OR
Goto c:users/user_name/android/ and then run this command
keytool -list -v -keystore debug.keystore -alias androiddebugkey -storepass android -keypass android

SHA keys would be generated, copy and paste it in the firebase console, where it's needed.



