

# Charge Lab Proof of Concept App
> Proof of concept app for the Charge Lab Coding Challenge. Performant, extensible, and easily maintainable app designed to be white labelled for partner brands. User authentication, registration, and email verification implemented with AWS Amplify.



## Screenshots
| ![Home Screen](https://user-images.githubusercontent.com/12676218/107737677-33983380-6cc2-11eb-9d19-a52123cd330d.jpg)Login Screen  |![SignUpScreen](https://user-images.githubusercontent.com/12676218/107737675-32ff9d00-6cc2-11eb-9c6a-b364a51706a1.jpg)Sign up Screen | ![Verification Screen](https://user-images.githubusercontent.com/12676218/107737676-32ff9d00-6cc2-11eb-9bae-cc509b98232c.jpg)Verification Screen |  ![Home Screen](https://user-images.githubusercontent.com/12676218/107737673-32670680-6cc2-11eb-80ce-ec7d30b06632.jpg)Home Screen  |
|:---:|:---:|:---:|:---:|


## Build
#### Building an AppBundle
~~~bash
cd APPDIR
flutter build appbundle --release
~~~

#### Building an APK
```bash
cd APPDIR
flutter build apk --split-per-abi --release
```

## Installation
#### Installing APK on a device
1. Connect Android device to your computer with a USB cable
2. Ensure Developer options are enabled and USB Debugging is allowed
3. Install the app
	```bash
   cd AppDir
   flutter install
   ```

#### Test Credentials
username: jonathanl

password: testtest
