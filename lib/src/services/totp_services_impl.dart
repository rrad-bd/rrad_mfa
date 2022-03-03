import 'dart:convert';
import 'package:rrad_mfa/rrad_mfa.dart';
import 'package:http/http.dart' as http;

class TOTPServiceImpl implements TOTPService {
  String _serverUrl = '';
  String? _totpApiKey;
  String? _smsApiKey;
  String _appName = 'RRAD';
  String _sendSmsOtpUrl = '/SendOTP';
  String _matchSmsOtpUrl = '/MatchOTP';
  String _registerUrl = '/totp/api/register';
  String _verifyUrl = '/totp/api/verify';
  String _validateUrl = '/totp/api/validate';

  @override
  void init({
    required String serverUrl,
    required String appName,
    String? totpApiKey,
    String? smsApiKey,
    String sendSmsOtpUrl = '/SendOTP',
    String matchSmsOtpUrl = '/MatchOTP',
    String registerUrl = '/totp/api/register',
    String verifyUrl = '/totp/api/verify',
    String validateUrl = '/totp/api/validate',
  }) {
    _appName = appName;
    _totpApiKey = totpApiKey;
    _smsApiKey = smsApiKey;
    _sendSmsOtpUrl = sendSmsOtpUrl;
    _matchSmsOtpUrl = matchSmsOtpUrl;
    _serverUrl = serverUrl.endsWith('/')
        ? serverUrl.substring(0, serverUrl.length - 1)
        : serverUrl;
    _registerUrl =
        !registerUrl.startsWith('/') ? ('/' + registerUrl) : registerUrl;
    _verifyUrl = !verifyUrl.startsWith('/') ? ('/' + verifyUrl) : verifyUrl;
    _validateUrl =
        !validateUrl.startsWith('/') ? ('/' + validateUrl) : validateUrl;
  }

  @override
  Future<TOTPResponse<TOTP?>> registerOtp({
    String? userId,
  }) async {
    assert(
      _totpApiKey != null && _totpApiKey!.isNotEmpty,
      'TOTP API Key is required.',
    );
    assert(
      _registerUrl.isNotEmpty,
      'Register URL is required.',
    );

    TOTPResponse<TOTP?> res;
    var response = await http.post(
      Uri.parse(_serverUrl + _registerUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: userId != null
          ? jsonEncode(
              <String, String>{
                'userId': userId,
                'apiKey': _totpApiKey!,
              },
            )
          : null,
    );
    if (response.statusCode == 200) {
      res = TOTPResponse<TOTP>(
        success: true,
        statusCode: 200,
        result: TOTP.fromJson(response.body),
      );
    } else {
      res = TOTPResponse(
        success: false,
        statusCode: response.statusCode,
        errorMessage: json.decode(response.body)['message'] ?? 'Failed',
      );
    }
    return res;
  }

  @override
  Future<TOTPResponse<bool?>> verifyOtp({
    required String token,
    required String userId,
  }) async {
    assert(
      _totpApiKey != null && _totpApiKey!.isNotEmpty,
      'TOTP API Key is required.',
    );
    assert(
      _verifyUrl.isNotEmpty,
      'Verify URL is required.',
    );
    TOTPResponse<bool?> res;
    var response = await http.post(
      Uri.parse(_serverUrl + _verifyUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'token': token,
          'userId': userId,
          'apiKey': _totpApiKey!,
        },
      ),
    );
    var body = json.decode(response.body);
    if (response.statusCode == 200) {
      res = TOTPResponse(
        success: true,
        statusCode: 200,
        result: body['verified'],
      );
    } else {
      res = TOTPResponse(
        success: false,
        statusCode: response.statusCode,
        errorMessage: body['message'] ?? 'Failed',
      );
    }

    return res;
  }

  @override
  Future<TOTPResponse<bool?>> validateOtp({
    required String token,
    required String userId,
  }) async {
    assert(
      _totpApiKey != null && _totpApiKey!.isNotEmpty,
      'TOTP API Key is required.',
    );
    assert(
      _validateUrl.isNotEmpty,
      'Validate URL is required.',
    );
    TOTPResponse<bool?> res;
    var response = await http.post(
      Uri.parse(
        _serverUrl + _validateUrl,
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'token': token,
          'userId': userId,
          'apiKey': _totpApiKey!,
        },
      ),
    );
    var body = json.decode(response.body);
    if (response.statusCode == 200) {
      res = TOTPResponse(
        success: true,
        statusCode: 200,
        result: body['validated'],
      );
    } else {
      res = TOTPResponse(
        success: false,
        statusCode: response.statusCode,
        errorMessage: body['message'] ?? 'Failed',
      );
    }

    return res;
  }

  @override
  Future<TOTPResponse<bool?>> validateSmsOtp({
    required String phoneNumber,
    required String token,
  }) async {
    assert(
      _smsApiKey != null && _smsApiKey!.isNotEmpty,
      'SMS API Key is required.',
    );
    assert(
      _matchSmsOtpUrl.isNotEmpty,
      'Match SMS OTP URL is required.',
    );
    TOTPResponse<bool?> res;
    var response = await http.get(
      Uri.parse(
        _serverUrl +
            _matchSmsOtpUrl +
            '?phoneNumber=$phoneNumber&otp=$token&apiKey=$_smsApiKey',
      ),
    );
    var body = json.decode(response.body);
    if (response.statusCode == 200) {
      res = TOTPResponse(
        success: true,
        statusCode: 200,
        successMessage: body['message'],
        result: body['matched'],
      );
    } else {
      res = TOTPResponse(
        success: false,
        statusCode: response.statusCode,
        errorMessage: body['message'] ?? 'Failed',
      );
    }
    return res;
  }

  @override
  Future<TOTPResponse<bool?>> sendSmsOtp({
    required String phoneNumber,
  }) async {
    assert(
      _appName.isNotEmpty,
      'App Name is required.',
    );
    assert(
      _smsApiKey != null && _smsApiKey!.isNotEmpty,
      'SMS API Key is required.',
    );
    TOTPResponse<bool?> res;
    var response = await http.get(
      Uri.parse(
        _serverUrl +
            _sendSmsOtpUrl +
            '?phoneNumber=$phoneNumber&apiKey=$_smsApiKey&appName=$_appName',
      ),
    );
    var body = json.decode(response.body);
    if (response.statusCode == 200) {
      res = TOTPResponse(
        success: true,
        statusCode: 200,
        successMessage: body['message'],
        result: body['send'],
      );
    } else {
      res = TOTPResponse(
        success: false,
        statusCode: response.statusCode,
        errorMessage: body['message'] ?? 'Failed',
      );
    }
    return res;
  }
}
