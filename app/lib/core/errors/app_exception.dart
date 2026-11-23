/// Stable RPC failure. [code] is an `SIxxx` value from the backend.
class AppException implements Exception {
  const AppException(this.code, {this.detail});

  final String code;
  final String? detail;

  @override
  String toString() => 'AppException($code)';
}
