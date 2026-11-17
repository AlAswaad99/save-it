import 'package:flutter/widgets.dart';
import 'package:save_it/l10n/app_localizations.dart';

extension AppLocalizationsContext on BuildContext {
  AppLocalizations get l10n {
    final localizations = AppLocalizations.of(this);
    if (localizations == null) {
      throw StateError('AppLocalizations is not installed');
    }
    return localizations;
  }
}
