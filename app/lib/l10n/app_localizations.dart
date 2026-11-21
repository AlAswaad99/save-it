import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// Application title shown by the operating system.
  ///
  /// In en, this message translates to:
  /// **'Save It'**
  String get appTitle;

  /// Explore tab label.
  ///
  /// In en, this message translates to:
  /// **'Explore'**
  String get tabExplore;

  /// Orders tab label.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get tabOrders;

  /// Profile tab label.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get tabProfile;

  /// Empty Explore tab while discovery is not built yet.
  ///
  /// In en, this message translates to:
  /// **'Nearby surplus will show up here.'**
  String get explorePlaceholder;

  /// Empty Orders tab while orders are not built yet.
  ///
  /// In en, this message translates to:
  /// **'Your reservations will show up here.'**
  String get ordersPlaceholder;

  /// Empty Profile tab while the account screens are not built yet.
  ///
  /// In en, this message translates to:
  /// **'Sign in to manage your account.'**
  String get profilePlaceholder;

  /// Semantics label for the supplied La Logo.png mark.
  ///
  /// In en, this message translates to:
  /// **'Save It logo'**
  String get logoSemantics;

  /// Title of the dev-flavor widget gallery.
  ///
  /// In en, this message translates to:
  /// **'Widget gallery'**
  String get galleryTitle;

  /// Dev-flavor Profile action that opens the widget gallery.
  ///
  /// In en, this message translates to:
  /// **'Widget gallery'**
  String get galleryOpen;

  /// No description provided for @gallerySectionButtons.
  ///
  /// In en, this message translates to:
  /// **'Buttons'**
  String get gallerySectionButtons;

  /// No description provided for @gallerySectionInputs.
  ///
  /// In en, this message translates to:
  /// **'Inputs'**
  String get gallerySectionInputs;

  /// No description provided for @gallerySectionCard.
  ///
  /// In en, this message translates to:
  /// **'Card'**
  String get gallerySectionCard;

  /// No description provided for @gallerySectionBadges.
  ///
  /// In en, this message translates to:
  /// **'Badges'**
  String get gallerySectionBadges;

  /// No description provided for @gallerySectionStates.
  ///
  /// In en, this message translates to:
  /// **'States'**
  String get gallerySectionStates;

  /// No description provided for @buttonPrimary.
  ///
  /// In en, this message translates to:
  /// **'Primary'**
  String get buttonPrimary;

  /// No description provided for @buttonSecondary.
  ///
  /// In en, this message translates to:
  /// **'Secondary'**
  String get buttonSecondary;

  /// No description provided for @buttonText.
  ///
  /// In en, this message translates to:
  /// **'Text'**
  String get buttonText;

  /// No description provided for @buttonDestructive.
  ///
  /// In en, this message translates to:
  /// **'Destructive'**
  String get buttonDestructive;

  /// No description provided for @buttonDisabled.
  ///
  /// In en, this message translates to:
  /// **'Disabled'**
  String get buttonDisabled;

  /// Semantics label while a button is busy.
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get buttonLoading;

  /// No description provided for @fieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get fieldLabel;

  /// No description provided for @fieldHint.
  ///
  /// In en, this message translates to:
  /// **'name@example.com'**
  String get fieldHint;

  /// No description provided for @fieldError.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email.'**
  String get fieldError;

  /// No description provided for @fieldDisabledLabel.
  ///
  /// In en, this message translates to:
  /// **'Disabled'**
  String get fieldDisabledLabel;

  /// No description provided for @cardTitle.
  ///
  /// In en, this message translates to:
  /// **'Restaurant'**
  String get cardTitle;

  /// No description provided for @cardBody.
  ///
  /// In en, this message translates to:
  /// **'Surplus meals available for pickup today.'**
  String get cardBody;

  /// No description provided for @badgeReserved.
  ///
  /// In en, this message translates to:
  /// **'Reserved'**
  String get badgeReserved;

  /// No description provided for @badgeCollected.
  ///
  /// In en, this message translates to:
  /// **'Collected'**
  String get badgeCollected;

  /// No description provided for @badgeCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get badgeCancelled;

  /// No description provided for @badgeExpired.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get badgeExpired;

  /// No description provided for @badgeDraft.
  ///
  /// In en, this message translates to:
  /// **'Draft'**
  String get badgeDraft;

  /// No description provided for @badgeLive.
  ///
  /// In en, this message translates to:
  /// **'Live'**
  String get badgeLive;

  /// No description provided for @badgeSoldOut.
  ///
  /// In en, this message translates to:
  /// **'Sold out'**
  String get badgeSoldOut;

  /// No description provided for @badgeHidden.
  ///
  /// In en, this message translates to:
  /// **'Hidden'**
  String get badgeHidden;

  /// No description provided for @galleryEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Nothing here yet'**
  String get galleryEmptyTitle;

  /// No description provided for @galleryEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'This is the empty state.'**
  String get galleryEmptyBody;

  /// No description provided for @galleryErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get galleryErrorTitle;

  /// No description provided for @galleryErrorBody.
  ///
  /// In en, this message translates to:
  /// **'This is the error state.'**
  String get galleryErrorBody;

  /// No description provided for @errorRetry.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get errorRetry;

  /// Semantics label for the skeleton loading state.
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get loadingLabel;

  /// Banner shown when the phone has no connection.
  ///
  /// In en, this message translates to:
  /// **'You are offline. A saved pickup pass still opens.'**
  String get offlineBanner;

  /// Fallback when an RPC returns a code the app does not recognise yet.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong ({code}).'**
  String errorUnknown(String code);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
