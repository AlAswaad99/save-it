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

  /// C-29 first slide title.
  ///
  /// In en, this message translates to:
  /// **'Save food, Save money!'**
  String get walkthrough1Title;

  /// C-29 first slide body.
  ///
  /// In en, this message translates to:
  /// **'Join many others in reducing food waste as food venues around Abu Dhabi share their surplus food every evening at a discounted rate! Why let good food go to waste?'**
  String get walkthrough1Body;

  /// C-29 second slide title.
  ///
  /// In en, this message translates to:
  /// **'Make your reservation'**
  String get walkthrough2Title;

  /// C-29 second slide body.
  ///
  /// In en, this message translates to:
  /// **'Select what you want and get a unique pick up code, in just a few taps!'**
  String get walkthrough2Body;

  /// C-29 third slide title.
  ///
  /// In en, this message translates to:
  /// **'Collect and pay at location'**
  String get walkthrough3Title;

  /// C-29 third slide body.
  ///
  /// In en, this message translates to:
  /// **'Simply go to your selected food venue, show your unique code between the pick up time & collect your order!'**
  String get walkthrough3Body;

  /// No description provided for @actionSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get actionSkip;

  /// No description provided for @actionNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get actionNext;

  /// No description provided for @actionGetStarted.
  ///
  /// In en, this message translates to:
  /// **'Get started'**
  String get actionGetStarted;

  /// C-02 location sheet title.
  ///
  /// In en, this message translates to:
  /// **'See food venues near you.'**
  String get locationSheetTitle;

  /// C-02 location sheet body.
  ///
  /// In en, this message translates to:
  /// **'Allow location to see all the food venues with discounts available today!'**
  String get locationSheetBody;

  /// No description provided for @actionAllowLocation.
  ///
  /// In en, this message translates to:
  /// **'Allow location'**
  String get actionAllowLocation;

  /// No description provided for @actionChooseAreaInstead.
  ///
  /// In en, this message translates to:
  /// **'Choose area instead'**
  String get actionChooseAreaInstead;

  /// No description provided for @chooseAreaTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose your area'**
  String get chooseAreaTitle;

  /// No description provided for @searchAreasHint.
  ///
  /// In en, this message translates to:
  /// **'Search areas'**
  String get searchAreasHint;

  /// No description provided for @areasHeader.
  ///
  /// In en, this message translates to:
  /// **'Abu Dhabi areas'**
  String get areasHeader;

  /// No description provided for @actionShowRestaurants.
  ///
  /// In en, this message translates to:
  /// **'Show restaurants'**
  String get actionShowRestaurants;

  /// No description provided for @currentLocation.
  ///
  /// In en, this message translates to:
  /// **'Current location'**
  String get currentLocation;

  /// No description provided for @areasLoadError.
  ///
  /// In en, this message translates to:
  /// **'The area list could not be loaded.'**
  String get areasLoadError;

  /// No description provided for @actionContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get actionContinue;

  /// No description provided for @actionContinueWithEmail.
  ///
  /// In en, this message translates to:
  /// **'Continue with email'**
  String get actionContinueWithEmail;

  /// No description provided for @actionSendCode.
  ///
  /// In en, this message translates to:
  /// **'Send code'**
  String get actionSendCode;

  /// No description provided for @actionResendCode.
  ///
  /// In en, this message translates to:
  /// **'Resend code'**
  String get actionResendCode;

  /// No description provided for @signUpGateTitle.
  ///
  /// In en, this message translates to:
  /// **'Log in or sign up to reserve.'**
  String get signUpGateTitle;

  /// No description provided for @signUpGateBody.
  ///
  /// In en, this message translates to:
  /// **'You can keep browsing as a guest. Enter your email to reserve; there\'s no password.'**
  String get signUpGateBody;

  /// No description provided for @emailAppBar.
  ///
  /// In en, this message translates to:
  /// **'Log in or sign up'**
  String get emailAppBar;

  /// No description provided for @emailHeading.
  ///
  /// In en, this message translates to:
  /// **'What\'s your email?'**
  String get emailHeading;

  /// No description provided for @emailBody.
  ///
  /// In en, this message translates to:
  /// **'We\'ll send a 6-digit code. New to Save It? You\'ll add your details next.'**
  String get emailBody;

  /// No description provided for @fieldEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get fieldEmail;

  /// No description provided for @codeAppBar.
  ///
  /// In en, this message translates to:
  /// **'Enter code'**
  String get codeAppBar;

  /// No description provided for @codeHeading.
  ///
  /// In en, this message translates to:
  /// **'Check your email.'**
  String get codeHeading;

  /// No description provided for @codeSentTo.
  ///
  /// In en, this message translates to:
  /// **'Code sent to {maskedEmail}.'**
  String codeSentTo(String maskedEmail);

  /// No description provided for @codeDidntGetIt.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t get it?'**
  String get codeDidntGetIt;

  /// No description provided for @codeErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Incorrect or expired code'**
  String get codeErrorTitle;

  /// No description provided for @codeErrorBody.
  ///
  /// In en, this message translates to:
  /// **'Check the code or request a new one.'**
  String get codeErrorBody;

  /// No description provided for @codeResendWait.
  ///
  /// In en, this message translates to:
  /// **'Try again in {minutes} min'**
  String codeResendWait(int minutes);

  /// No description provided for @codeResendLimit.
  ///
  /// In en, this message translates to:
  /// **'You can request up to 3 codes per hour.'**
  String get codeResendLimit;

  /// No description provided for @profileSetupAppBar.
  ///
  /// In en, this message translates to:
  /// **'Create your account'**
  String get profileSetupAppBar;

  /// No description provided for @profileSetupHeading.
  ///
  /// In en, this message translates to:
  /// **'Almost done.'**
  String get profileSetupHeading;

  /// No description provided for @profileSetupBody.
  ///
  /// In en, this message translates to:
  /// **'Tell us who\'s collecting the food.'**
  String get profileSetupBody;

  /// No description provided for @verified.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get verified;

  /// No description provided for @fieldFullName.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get fieldFullName;

  /// No description provided for @fieldPhone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get fieldPhone;

  /// No description provided for @phonePrefix.
  ///
  /// In en, this message translates to:
  /// **'+971'**
  String get phonePrefix;

  /// No description provided for @phoneInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid phone number.'**
  String get phoneInvalid;

  /// No description provided for @termsAgreePrefix.
  ///
  /// In en, this message translates to:
  /// **'I agree to the'**
  String get termsAgreePrefix;

  /// No description provided for @termsAgreeJoin.
  ///
  /// In en, this message translates to:
  /// **'and'**
  String get termsAgreeJoin;

  /// No description provided for @termsLink.
  ///
  /// In en, this message translates to:
  /// **'Terms and Conditions'**
  String get termsLink;

  /// No description provided for @privacyLink.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyLink;

  /// No description provided for @guestTitle.
  ///
  /// In en, this message translates to:
  /// **'You\'re browsing as a guest.'**
  String get guestTitle;

  /// No description provided for @guestBody.
  ///
  /// In en, this message translates to:
  /// **'Log in or sign up to reserve food and see your orders.'**
  String get guestBody;

  /// No description provided for @guestOrdersTitle.
  ///
  /// In en, this message translates to:
  /// **'Log in or sign up to see your orders'**
  String get guestOrdersTitle;

  /// No description provided for @guestOrdersBody.
  ///
  /// In en, this message translates to:
  /// **'Your reservations and pickup passes appear here.'**
  String get guestOrdersBody;

  /// No description provided for @actionLogOut.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get actionLogOut;
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
