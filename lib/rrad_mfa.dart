library rrad_mfa;

import 'dart:convert';
import 'dart:typed_data';

import 'package:rrad_mfa/src/services/totp_services_impl.dart';

part 'src/models/totp.dart';
part 'src/services/totp_service.dart';
part 'src/models/response.dart';

/// Initialize the instance of [RRADMFA]
/// {@tool snippet}
/// ```dart
/// void main() async {
///   WidgetsFlutterBinding.ensureInitialized();
///
///   RRADMFA.instance.init(
///     appName: 'RRAD', // Short name of your app
///     serverUrl: 'http://localhost:6969', // Your server url
///     totpApiKey: 'sdvsdvdaszfhvcedsth',   // Your api key for totp
///     smsApiKey: 'adsrgetwyetr',   // Your api key for sms otp
///   );
///
///   runApp(const MyApp());
/// }
/// ```
/// {@end-tool}
///
/// * Register userId for the first time in Time based OTP
///   {@tool snippet}
///   ```dart
///   TOTPResponse<TOTP?> result = await RRADMFA.instance.register();
///   ```
///   {@end-tool}
///
/// * Verify time based Otp for userId after registration
///   {@tool snippet}
///   ```dart
///   TOTPResponse<TOTP?> result = await RRADMFA.instance.verify(
///       userId: '', // userId stored from register response
///       otp: '',  // otp taken from user
///   );
///   ```
///   {@end-tool}
///
/// * Validate Time based Otp for userId
///   {@tool snippet}
///   ```dart
///   TOTPResponse<TOTP?> result = await RRADMFA.instance.validate(
///      userId: '', // userId stored from register response
///      otp: '',  // otp taken from user
///   );
///   ```
///   {@end-tool}
///
/// * Send Sms Otp to phone number
///   {@tool snippet}
///   ```dart
///   TOTPResponse<TOTP?> result = await RRADMFA.instance.sendSmsOtp(
///      phoneNumber: '', // phone number of user
///   );
///   ```
///   {@end-tool}
///
/// * Validate Sms Otp sent to phone number
///   {@tool snippet}
///   ```dart
///   TOTPResponse<TOTP?> result = await RRADMFA.instance.validateSmsOtp(
///     phoneNumber: '', // phone number of user
///     otp: '',  // otp taken from user
///   );
///   ```
///   {@end-tool}

class RRADMFA {
  /// Instance of [RRADMFA]
  ///
  /// Initialize the instance of [RRADMFA]
  /// {@tool snippet}
  /// ```dart
  /// void main() async {
  ///   WidgetsFlutterBinding.ensureInitialized();
  ///
  ///   RRADMFA.instance.init(
  ///     appName: 'RRAD', // Short name of your app
  ///     serverUrl: 'http://localhost:6969', // Your server url
  ///     totpApiKey: 'sdvsdvdaszfhvcedsth',   // Your api key for totp
  ///     smsApiKey: 'adsrgetwyetr',   // Your api key for sms otp
  ///   );
  ///
  ///   runApp(const MyApp());
  /// }
  /// ```
  /// {@end-tool}
  ///
  /// * Register userId for the first time in Time based OTP
  ///   {@tool snippet}
  ///   ```dart
  ///   TOTPResponse<TOTP?> result = await RRADMFA.instance.register();
  ///   ```
  ///   {@end-tool}
  ///
  /// * Verify time based Otp for userId after registration
  ///   {@tool snippet}
  ///   ```dart
  ///   TOTPResponse<TOTP?> result = await RRADMFA.instance.verify(
  ///       userId: '', // userId stored from register response
  ///       otp: '',  // otp taken from user
  ///   );
  ///   ```
  ///   {@end-tool}
  ///
  /// * Validate Time based Otp for userId
  ///   {@tool snippet}
  ///   ```dart
  ///   TOTPResponse<TOTP?> result = await RRADMFA.instance.validate(
  ///      userId: '', // userId stored from register response
  ///      otp: '',  // otp taken from user
  ///   );
  ///   ```
  ///   {@end-tool}
  ///
  /// * Send Sms Otp to phone number
  ///   {@tool snippet}
  ///   ```dart
  ///   TOTPResponse<TOTP?> result = await RRADMFA.instance.sendSmsOtp(
  ///      phoneNumber: '', // phone number of user
  ///   );
  ///   ```
  ///   {@end-tool}
  ///
  /// * Validate Sms Otp sent to phone number
  ///   {@tool snippet}
  ///   ```dart
  ///   TOTPResponse<TOTP?> result = await RRADMFA.instance.validateSmsOtp(
  ///     phoneNumber: '', // phone number of user
  ///     otp: '',  // otp taken from user
  ///   );
  ///   ```
  ///   {@end-tool}
  static final RRADMFA instance = RRADMFA._internal();
  final TOTPService _service = TOTPServiceImpl();

  factory RRADMFA() {
    return instance;
  }

  RRADMFA._internal();

  /// Initialize the instance of [RRADMFA]
  /// {@tool snippet}
  /// ```dart
  /// void main() async {
  ///   WidgetsFlutterBinding.ensureInitialized();
  ///
  ///   RRADMFA.instance.init(
  ///     appName: 'RRAD', // Short name of your app
  ///     serverUrl: 'http://localhost:1807', // Your server url
  ///     totpApiKey: 'sdvsdvdaszfhvcedsth',   // Your api key for totp
  ///     smsApiKey: 'adsrgetwyetr',   // Your api key for sms otp
  ///   );
  ///
  ///   runApp(const MyApp());
  /// }
  /// ```
  /// {@end-tool}
  ///
  void init({
    required String appName,
    required String serverUrl,
    String? totpApiKey,
    String? smsApiKey,
    String sendSmsOtpUrl = '/SendOTP',
    String matchSmsOtpUrl = '/MatchOTP',
    String registerUrl = '/totp/api/register',
    String verifyUrl = '/totp/api/verify',
    String validateUrl = '/totp/api/validate',
  }) {
    assert(
      serverUrl.isNotEmpty,
      'Server URL is not set. Please set server url',
    );
    assert(
      appName.isNotEmpty,
      'App Name cannot be empty.',
    );
    _service.init(
      appName: appName,
      serverUrl: serverUrl,
      totpApiKey: totpApiKey,
      smsApiKey: smsApiKey,
      sendSmsOtpUrl: sendSmsOtpUrl,
      matchSmsOtpUrl: matchSmsOtpUrl,
      registerUrl: registerUrl,
      verifyUrl: verifyUrl,
      validateUrl: validateUrl,
    );
  }

  /// Register userId for the first time in Time based OTP
  ///
  /// UserId of your user (optional).
  /// If not provided, it will be generated automatically
  /// {@tool snippet}
  /// ```dart
  /// TOTPResponse<TOTP?> result = await RRADMFA.instance.register();
  /// ```
  /// {@end-tool}
  ///

  Future<TOTPResponse<TOTP?>> register({
    String? userId,
  }) async {
    return _service.registerOtp(
      userId: userId,
    );
  }

  /// Verify time based Otp for userId after registration
  /// {@tool snippet}
  /// ```dart
  /// TOTPResponse<TOTP?> result = await RRADMFA.instance.verify(
  ///     userId: '', // userId stored from register response
  ///     otp: '',  // otp taken from user
  /// );
  /// ```
  /// {@end-tool}
  ///

  Future<TOTPResponse<bool?>> verify({
    required String userId,
    required String otp,
  }) async {
    assert(
      otp.isNotEmpty,
      'OTP cannot be empty.',
    );
    assert(
      userId.isNotEmpty,
      'UserId cannot be empty.',
    );
    return _service.verifyOtp(
      userId: userId,
      token: otp,
    );
  }

  /// Validate Time based Otp for userId
  /// {@tool snippet}
  /// ```dart
  /// TOTPResponse<TOTP?> result = await RRADMFA.instance.validate(
  ///    userId: '', // userId stored from register response
  ///    otp: '',  // otp taken from user
  /// );
  /// ```
  /// {@end-tool}
  ///
  Future<TOTPResponse<bool?>> validate({
    required String userId,
    required String otp,
  }) async {
    assert(
      userId.isNotEmpty,
      'UserId cannot be empty.',
    );
    assert(
      otp.isNotEmpty,
      'OTP cannot be empty.',
    );
    assert(
      otp.length == 6,
      'OTP must be 6 digits.',
    );
    return _service.validateOtp(
      userId: userId,
      token: otp,
    );
  }

  /// Send Sms Otp to phone number
  /// {@tool snippet}
  /// ```dart
  /// TOTPResponse<TOTP?> result = await RRADMFA.instance.sendSmsOtp(
  ///    phoneNumber: '', // phone number of user
  /// );
  /// ```
  /// {@end-tool}
  Future<TOTPResponse<bool?>> sendSmsOtp({
    required String phoneNumber,
  }) async {
    assert(
      phoneNumber.isNotEmpty,
      'Phone number cannot be empty.',
    );
    assert(
      phoneNumber.length <= 18,
      'Phone number cannot be more than 18 characters.',
    );
    assert(
      phoneNumber.length >= 10,
      'Phone number cannot be less than 10 characters.',
    );
    return _service.sendSmsOtp(
      phoneNumber: phoneNumber,
    );
  }

  /// Validate Sms Otp to phone number
  /// {@tool snippet}
  /// ```dart
  /// TOTPResponse<TOTP?> result = await RRADMFA.instance.validateSmsOtp(
  ///   phoneNumber: '', // phone number of user
  ///   otp: '',  // otp taken from user
  /// );
  /// ```
  /// {@end-tool}
  Future<TOTPResponse<bool?>> validateSmsOtp({
    required String phoneNumber,
    required String otp,
  }) async {
    assert(
      phoneNumber.isNotEmpty,
      'Phone number cannot be empty.',
    );
    assert(
      phoneNumber.length <= 18,
      'Phone number cannot be more than 18 characters.',
    );
    assert(
      phoneNumber.length >= 10,
      'Phone number cannot be less than 10 characters.',
    );
    assert(
      otp.isNotEmpty,
      'OTP cannot be empty.',
    );
    assert(
      otp.length == 6,
      'OTP must be 6 digits.',
    );
    return _service.validateSmsOtp(
      phoneNumber: phoneNumber,
      token: otp,
    );
  }
}
