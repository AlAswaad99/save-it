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

  /// No description provided for @errorSi001.
  ///
  /// In en, this message translates to:
  /// **'You cannot do that with this account.'**
  String get errorSi001;

  /// No description provided for @errorSi002.
  ///
  /// In en, this message translates to:
  /// **'This account is suspended.'**
  String get errorSi002;

  /// No description provided for @errorSi002Contact.
  ///
  /// In en, this message translates to:
  /// **'This account is suspended. Contact {email}.'**
  String errorSi002Contact(String email);

  /// No description provided for @errorSi003.
  ///
  /// In en, this message translates to:
  /// **'You already have the maximum number of active orders.'**
  String get errorSi003;

  /// No description provided for @errorSi003Max.
  ///
  /// In en, this message translates to:
  /// **'You can have {max} active orders at a time.'**
  String errorSi003Max(int max);

  /// No description provided for @errorSi004.
  ///
  /// In en, this message translates to:
  /// **'That quantity is over the limit for this listing.'**
  String get errorSi004;

  /// No description provided for @errorSi004Max.
  ///
  /// In en, this message translates to:
  /// **'You can reserve at most {max} from one listing.'**
  String errorSi004Max(int max);

  /// No description provided for @errorSi005.
  ///
  /// In en, this message translates to:
  /// **'There is not enough of that item left.'**
  String get errorSi005;

  /// No description provided for @errorSi005Available.
  ///
  /// In en, this message translates to:
  /// **'Only {available} left of that item.'**
  String errorSi005Available(int available);

  /// No description provided for @errorSi006.
  ///
  /// In en, this message translates to:
  /// **'That item is no longer available.'**
  String get errorSi006;

  /// No description provided for @errorSi007.
  ///
  /// In en, this message translates to:
  /// **'A basket can only hold items from one restaurant.'**
  String get errorSi007;

  /// No description provided for @errorSi010.
  ///
  /// In en, this message translates to:
  /// **'Choose a pickup time inside the allowed hours.'**
  String get errorSi010;

  /// No description provided for @errorSi011.
  ///
  /// In en, this message translates to:
  /// **'The pickup window has to be today.'**
  String get errorSi011;

  /// No description provided for @errorSi012.
  ///
  /// In en, this message translates to:
  /// **'That pickup window clashes with orders already reserved.'**
  String get errorSi012;

  /// No description provided for @errorSi013.
  ///
  /// In en, this message translates to:
  /// **'This restaurant is suspended.'**
  String get errorSi013;

  /// No description provided for @errorSi013Contact.
  ///
  /// In en, this message translates to:
  /// **'This restaurant is suspended. Contact {email}.'**
  String errorSi013Contact(String email);

  /// No description provided for @errorSi020.
  ///
  /// In en, this message translates to:
  /// **'The discount is below the minimum.'**
  String get errorSi020;

  /// No description provided for @errorSi021.
  ///
  /// In en, this message translates to:
  /// **'The quantity cannot be lower than the amount already reserved.'**
  String get errorSi021;

  /// No description provided for @errorSi021Reserved.
  ///
  /// In en, this message translates to:
  /// **'The quantity cannot be lower than the {reserved} already reserved.'**
  String errorSi021Reserved(int reserved);

  /// No description provided for @errorSi030.
  ///
  /// In en, this message translates to:
  /// **'That code does not match an order at this restaurant.'**
  String get errorSi030;

  /// No description provided for @errorSi031.
  ///
  /// In en, this message translates to:
  /// **'This order was already collected.'**
  String get errorSi031;

  /// No description provided for @errorSi032.
  ///
  /// In en, this message translates to:
  /// **'This order has expired.'**
  String get errorSi032;

  /// No description provided for @errorSi033.
  ///
  /// In en, this message translates to:
  /// **'This order was cancelled.'**
  String get errorSi033;

  /// No description provided for @errorSi034.
  ///
  /// In en, this message translates to:
  /// **'Pickup has not started yet.'**
  String get errorSi034;

  /// No description provided for @errorSi040.
  ///
  /// In en, this message translates to:
  /// **'Choose a reason for the cancellation.'**
  String get errorSi040;

  /// No description provided for @errorSi041.
  ///
  /// In en, this message translates to:
  /// **'This order cannot be cancelled.'**
  String get errorSi041;

  /// No description provided for @errorSi050.
  ///
  /// In en, this message translates to:
  /// **'Too many codes were sent. Try again later.'**
  String get errorSi050;

  /// No description provided for @errorSi050Wait.
  ///
  /// In en, this message translates to:
  /// **'Too many codes were sent. Try again in {minutes} minutes.'**
  String errorSi050Wait(int minutes);

  /// No description provided for @errorSi051.
  ///
  /// In en, this message translates to:
  /// **'Add your name, phone, and acceptance of the terms to continue.'**
  String get errorSi051;

  /// No description provided for @errorSi060.
  ///
  /// In en, this message translates to:
  /// **'This account cannot be deleted while an order is still reserved.'**
  String get errorSi060;

  /// No description provided for @errorSi070.
  ///
  /// In en, this message translates to:
  /// **'An admin cannot reset or deactivate their own account.'**
  String get errorSi070;
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
