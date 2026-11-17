// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Save it';

  @override
  String get tabExplore => 'Explore';

  @override
  String get tabOrders => 'Orders';

  @override
  String get tabProfile => 'Profile';

  @override
  String get explorePlaceholder => 'Nearby surplus will show up here.';

  @override
  String get ordersPlaceholder => 'Your reservations will show up here.';

  @override
  String get profilePlaceholder => 'Sign in to manage your account.';

  @override
  String errorUnknown(String code) {
    return 'Something went wrong ($code).';
  }
}
