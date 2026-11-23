import 'dart:convert';

import 'package:save_it/l10n/app_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app_exception.dart';

/// Maps an RPC error code to the single English catalogue in `app_en.arb`.
///
/// Codes and their detail fields match `docs/03-backend-api.md` §1.
String messageForCode(
  AppLocalizations l10n,
  String code, {
  String? detail,
}) {
  final data = _detailMap(detail);
  switch (code) {
    case 'SI001':
      return l10n.errorSi001;
    case 'SI002':
      final email = _string(data, 'support_email');
      return email == null ? l10n.errorSi002 : l10n.errorSi002Contact(email);
    case 'SI003':
      final max = _int(data, 'max');
      return max == null ? l10n.errorSi003 : l10n.errorSi003Max(max);
    case 'SI004':
      final max = _int(data, 'max');
      return max == null ? l10n.errorSi004 : l10n.errorSi004Max(max);
    case 'SI005':
      final available = _int(data, 'available');
      return available == null
          ? l10n.errorSi005
          : l10n.errorSi005Available(available);
    case 'SI006':
      return l10n.errorSi006;
    case 'SI007':
      return l10n.errorSi007;
    case 'SI010':
      return l10n.errorSi010;
    case 'SI011':
      return l10n.errorSi011;
    case 'SI012':
      return l10n.errorSi012;
    case 'SI013':
      final email = _string(data, 'support_email');
      return email == null ? l10n.errorSi013 : l10n.errorSi013Contact(email);
    case 'SI020':
      return l10n.errorSi020;
    case 'SI021':
      final reserved = _int(data, 'reserved');
      return reserved == null ? l10n.errorSi021 : l10n.errorSi021Reserved(reserved);
    case 'SI030':
      return l10n.errorSi030;
    case 'SI031':
      return l10n.errorSi031;
    case 'SI032':
      return l10n.errorSi032;
    case 'SI033':
      return l10n.errorSi033;
    case 'SI034':
      return l10n.errorSi034;
    case 'SI040':
      return l10n.errorSi040;
    case 'SI041':
      return l10n.errorSi041;
    case 'SI050':
      final minutes = _int(data, 'retry_after_min');
      return minutes == null ? l10n.errorSi050 : l10n.errorSi050Wait(minutes);
    case 'SI051':
      return l10n.errorSi051;
    case 'SI060':
      return l10n.errorSi060;
    case 'SI070':
      return l10n.errorSi070;
    default:
      return l10n.errorUnknown(code);
  }
}

/// Turns a PostgREST failure into [AppException] when the database sent an
/// `SIxxx` code.
AppException exceptionFromPostgrest(PostgrestException error) {
  final detail = _detailText(error.details);
  final source = '${error.message} $detail';
  final match = RegExp(r'SI\d{3}').firstMatch(source);
  return AppException(
    match?.group(0) ?? error.code ?? 'UNKNOWN',
    detail: detail,
  );
}

Map<String, dynamic>? _detailMap(String? detail) {
  if (detail == null || detail.isEmpty) {
    return null;
  }
  try {
    final decoded = jsonDecode(detail);
    if (decoded is Map<String, dynamic>) {
      return decoded;
    }
    if (decoded is Map) {
      return Map<String, dynamic>.from(decoded);
    }
  } on FormatException {
    return null;
  }
  return null;
}

String? _detailText(Object? details) {
  if (details == null) {
    return null;
  }
  if (details is String) {
    return details;
  }
  if (details is Map || details is List) {
    return jsonEncode(details);
  }
  return details.toString();
}

String? _string(Map<String, dynamic>? data, String key) {
  final value = data?[key];
  if (value is String && value.isNotEmpty) {
    return value;
  }
  return null;
}

int? _int(Map<String, dynamic>? data, String key) {
  final value = data?[key];
  if (value is num) {
    return value.round();
  }
  return null;
}
