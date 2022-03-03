part of rrad_mfa;

abstract class TOTPService {
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
  });
  Future<TOTPResponse<TOTP?>> registerOtp({
    String? userId,
  });

  Future<TOTPResponse<bool?>> verifyOtp({
    required String token,
    required String userId,
  });

  Future<TOTPResponse<bool?>> validateOtp({
    required String token,
    required String userId,
  });

  Future<TOTPResponse<bool?>> sendSmsOtp({
    required String phoneNumber,
  });

  Future<TOTPResponse<bool?>> validateSmsOtp({
    required String phoneNumber,
    required String token,
  });
}
