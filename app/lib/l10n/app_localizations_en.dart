// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Save It';

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
  String get logoSemantics => 'Save It logo';

  @override
  String get galleryTitle => 'Widget gallery';

  @override
  String get galleryOpen => 'Widget gallery';

  @override
  String get gallerySectionButtons => 'Buttons';

  @override
  String get gallerySectionInputs => 'Inputs';

  @override
  String get gallerySectionCard => 'Card';

  @override
  String get gallerySectionBadges => 'Badges';

  @override
  String get gallerySectionStates => 'States';

  @override
  String get buttonPrimary => 'Primary';

  @override
  String get buttonSecondary => 'Secondary';

  @override
  String get buttonText => 'Text';

  @override
  String get buttonDestructive => 'Destructive';

  @override
  String get buttonDisabled => 'Disabled';

  @override
  String get buttonLoading => 'Loading';

  @override
  String get fieldLabel => 'Email';

  @override
  String get fieldHint => 'name@example.com';

  @override
  String get fieldError => 'Enter a valid email.';

  @override
  String get fieldDisabledLabel => 'Disabled';

  @override
  String get cardTitle => 'Restaurant';

  @override
  String get cardBody => 'Surplus meals available for pickup today.';

  @override
  String get badgeReserved => 'Reserved';

  @override
  String get badgeCollected => 'Collected';

  @override
  String get badgeCancelled => 'Cancelled';

  @override
  String get badgeExpired => 'Expired';

  @override
  String get badgeDraft => 'Draft';

  @override
  String get badgeLive => 'Live';

  @override
  String get badgeSoldOut => 'Sold out';

  @override
  String get badgeHidden => 'Hidden';

  @override
  String get galleryEmptyTitle => 'Nothing here yet';

  @override
  String get galleryEmptyBody => 'This is the empty state.';

  @override
  String get galleryErrorTitle => 'Something went wrong';

  @override
  String get galleryErrorBody => 'This is the error state.';

  @override
  String get errorRetry => 'Try again';

  @override
  String get loadingLabel => 'Loading';

  @override
  String get offlineBanner =>
      'You are offline. A saved pickup pass still opens.';

  @override
  String errorUnknown(String code) {
    return 'Something went wrong ($code).';
  }
}
