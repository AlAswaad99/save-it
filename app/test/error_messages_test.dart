import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:save_it/core/errors/error_messages.dart';
import 'package:save_it/l10n/app_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
  late AppLocalizations l10n;

  setUpAll(() async {
    l10n = await AppLocalizations.delegate.load(const Locale('en'));
  });

  test('maps each catalogue code to its own sentence', () {
    expect(messageForCode(l10n, 'SI001'), l10n.errorSi001);
    expect(messageForCode(l10n, 'SI006'), 'That item is no longer available.');
    expect(messageForCode(l10n, 'SI011'), l10n.errorSi011);
    expect(messageForCode(l10n, 'SI051'), l10n.errorSi051);
    expect(messageForCode(l10n, 'SI070'), l10n.errorSi070);
    expect(
      messageForCode(l10n, 'SI999'),
      'Something went wrong (SI999).',
    );
  });

  test('uses the detail fields the API documents', () {
    expect(
      messageForCode(l10n, 'SI004', detail: '{"listing_id":"abc","max":2}'),
      'You can reserve at most 2 from one listing.',
    );
    expect(
      messageForCode(l10n, 'SI050', detail: '{"retry_after_min":12}'),
      'Too many codes were sent. Try again in 12 minutes.',
    );
    expect(
      messageForCode(l10n, 'SI050'),
      'Too many codes were sent. Try again later.',
    );
    expect(
      messageForCode(
        l10n,
        'SI002',
        detail: '{"support_email":"contact@arisehub.org"}',
      ),
      'This account is suspended. Contact contact@arisehub.org.',
    );
  });

  test('reads an SIxxx code out of a PostgREST error', () {
    final error = exceptionFromPostgrest(
      const PostgrestException(
        message: 'SI050',
        code: 'P0001',
        details: '{"retry_after_min":12}',
      ),
    );

    expect(error.code, 'SI050');
    expect(
      messageForCode(l10n, error.code, detail: error.detail),
      'Too many codes were sent. Try again in 12 minutes.',
    );
  });
}
