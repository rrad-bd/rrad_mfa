// ignore_for_file: non_constant_identifier_names

part of rrad_mfa;

Uint8List? _getImageFromData(String data) {
  Uint8List? image;
  if (data.isNotEmpty) {
    image = base64Decode(
      data.replaceAll(
        'data:image/png;base64,',
        '',
      ),
    );
  }
  return image;
}

class TOTP {
  String userid;
  Uint8List? qrcodeImage;
  Secrete temp_secret;
  TOTP({
    required this.userid,
    required this.temp_secret,
    this.qrcodeImage,
  });

  factory TOTP.fromMap(Map<String, dynamic> map) {
    return TOTP(
      userid: map['userid'] ?? '',
      qrcodeImage: _getImageFromData(map['qrcodeUrl'] ?? ''),
      temp_secret: Secrete.fromMap(map['temp_secret']),
    );
  }

  factory TOTP.fromJson(String source) => TOTP.fromMap(json.decode(source));

  @override
  String toString() =>
      'TOTP(userid: $userid, qrcodeImage: ${qrcodeImage.toString()}, temp_secret: ${temp_secret.toString()})';
}

class Secrete {
  String ascii;
  String hex;
  String base32;
  String? otpauth_url;
  Secrete({
    required this.ascii,
    required this.hex,
    required this.base32,
    this.otpauth_url,
  });

  Map<String, dynamic> toMap() {
    return {
      'ascii': ascii,
      'hex': hex,
      'base32': base32,
      'otpauth_url': otpauth_url,
    };
  }

  factory Secrete.fromMap(Map<String, dynamic> map) {
    return Secrete(
      ascii: map['ascii'] ?? '',
      hex: map['hex'] ?? '',
      base32: map['base32'] ?? '',
      otpauth_url: map['otpauth_url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Secrete.fromJson(String source) =>
      Secrete.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Secrete(ascii: $ascii, hex: $hex, base32: $base32, otpauth_url: $otpauth_url)';
  }
}
