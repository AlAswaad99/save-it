import 'package:save_it/l10n/app_localizations.dart';

/// Stable RPC failure. [code] is an `SIxxx` value from the backend.
class AppException implements Exception {
  const AppException(this.code, {this.detail});

  final String code;
  final String? detail;

  @override
  String toString() => 'AppException($code)';
}

/// Maps an RPC error code to the single English catalogue.
///
/// Specific codes are filled in as the RPCs land. Unknown codes keep the
/// code visible so a failure is still identifiable.
String messageForCode(AppLocalizations l10n, String code) {
  return l10n.errorUnknown(code);
}
