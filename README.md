# safety_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

OBTAINING SHA FINGERPRINTS:

--------------------------------------------------------------------------------------------------------------------

1) Download and install Java SDK (preferably in the default location).


2) Edit environment variables. Set JAVA_HOME to the location of jdk & Path to the location of bin.


3) Open VS Code terminal and check if 'keytool' is available.


[skip this step] Generate a key with this command & provide the necessary infos (default password is 'android'):   keytool -genkey -v -keystore c:\Users\USER_NAME\upload-keystore.jks -storetype JKS -keyalg RSA - keysize 2048 -validity 10000 - alias upload

4) Make sure that the file i send you is stored in this directory c:\Users\USER_NAME


5) Open command prompt & go to jdk bin directory and execute this command: keytool -list -v -keystore c:\Users\	USER_NAME\.android\debug.keystore -alias androiddebugkey -storepass android -keypass android

--------------------------------------------------------------------------------------------------------------------

Alias name: androiddebugkey
Creation date: 16 May 2021
Entry type: PrivateKeyEntry
Certificate chain length: 1
Certificate[1]:
Owner: C=US, O=Android, CN=Android Debug
Issuer: C=US, O=Android, CN=Android Debug
Serial number: 1
Valid from: Sun May 16 15:58:21 IST 2021 until: Tue May 09 15:58:21 IST 2051
Certificate fingerprints:
         SHA1: D5:E3:5E:FF:35:78:5C:5E:DE:65:1B:FE:D6:AC:2F:E3:4C:31:0D:BB
         SHA256: B1:CE:1E:AD:08:BB:68:E3:6A:39:50:A4:22:8F:A4:C4:44:F3:AD:51:76:B1:67:FB:D6:02:2F:E2:D7:2E:F4:C8
Signature algorithm name: SHA1withRSA (weak)
Subject Public Key Algorithm: 2048-bit RSA key
Version: 1

Warning:
The certificate uses the SHA1withRSA signature algorithm which is considered a security risk. This algorithm will be disabled in a future update.
The JKS keystore uses a proprietary format. It is recommended to migrate to PKCS12 which is an industry standard format using "keytool -importkeystore -srckeystore c:\Users\user\.android\debug.keystore -destkeystore c:\Users\user\.android\debug.keystore -deststoretype pkcs12".
