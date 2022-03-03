# _RRAD Multi Factor Authentication_

## Features

- Register Device for Time based OTP.
- Verify registration of Time based OTP.
- Validate Time based for registered devices with userId.
- Send sms OTP.
- Validate sms OTP.

## Installation

Add the package to your pubspec.yaml

```yaml
dependencies:
  rrad_mfa: any
```

Then you have to initialize the package instance to use it.

 ```dart
 void main() async {
   WidgetsFlutterBinding.ensureInitialized();

   RRADMFA.instance.init(
     appName: 'RRAD', // Short name of your app
     serverUrl: 'http://localhost:6969', // Your server url
     totpApiKey: 'sdvsdvdaszfhvcedsth',   // Your api key for totp
     smsApiKey: 'adsrgetwyetr',   // Your api key for sms otp
   );

   runApp(const MyApp());
 }
 ```

- If you want to use Time based OTP `totpApiKey` is required.
- If you want to use SMS based OTP `smsApiKey` is required.

## API Specifications

##### Register userId for the first time in Time based OTP

```dart
TOTPResponse<TOTP?> result = await RRADMFA.instance.register();
```

If the registration is successfull it will return secrets, userId and image Unit8List data for qrcode.
Use data to show image with Image.memory widget.

```dart
Image.memory(
    result.qrcodeImage!,
);
```

##### Verify time based Otp for userId after

```dart
TOTPResponse<TOTP?> result = await RRADMFA.instance.verify(
    userId: '', // userId stored from register response
    otp: '',  // otp taken from user
);
```

##### Validate Time based Otp for userId

```dart
TOTPResponse<TOTP?> result = await RRADMFA.instance.validate(
    userId: '', // userId stored from register response
    otp: '',  // otp taken from user
);
```

##### Send Sms Otp to phone number

`We are only sending sms otp to valid bangladeshi phone number for the time being.`

```dart
TOTPResponse<TOTP?> result = await RRADMFA.instance.sendSmsOtp(
    phoneNumber: '', // phone number of user
);
```

##### Validate Sms Otp sent to phone number

```dart
TOTPResponse<TOTP?> result = await RRADMFA.instance.validateSmsOtp(
    phoneNumber: '', // phone number of user
    otp: '',  // otp taken from user
);
```

Created with ❤️ by [RRAD](https://www.rrad.com.bd)
