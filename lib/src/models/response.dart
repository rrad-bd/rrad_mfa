part of rrad_mfa;

class TOTPResponse<T> {
  final bool success;
  final int statusCode;
  final String? errorMessage;
  final String? successMessage;
  final T? result;
  TOTPResponse({
    required this.success,
    required this.statusCode,
    this.result,
    this.errorMessage,
    this.successMessage,
  });

  @override
  String toString() =>
      'TOTPResponse(success: $success, statusCode: $statusCode, result: ${result.toString()})';
}
