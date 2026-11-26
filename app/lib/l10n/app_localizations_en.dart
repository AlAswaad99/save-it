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

  @override
  String get errorSi001 => 'You cannot do that with this account.';

  @override
  String get errorSi002 => 'This account is suspended.';

  @override
  String errorSi002Contact(String email) {
    return 'This account is suspended. Contact $email.';
  }

  @override
  String get errorSi003 =>
      'You already have the maximum number of active orders.';

  @override
  String errorSi003Max(int max) {
    return 'You can have $max active orders at a time.';
  }

  @override
  String get errorSi004 => 'That quantity is over the limit for this listing.';

  @override
  String errorSi004Max(int max) {
    return 'You can reserve at most $max from one listing.';
  }

  @override
  String get errorSi005 => 'There is not enough of that item left.';

  @override
  String errorSi005Available(int available) {
    return 'Only $available left of that item.';
  }

  @override
  String get errorSi006 => 'That item is no longer available.';

  @override
  String get errorSi007 => 'A basket can only hold items from one restaurant.';

  @override
  String get errorSi010 => 'Choose a pickup time inside the allowed hours.';

  @override
  String get errorSi011 => 'The pickup window has to be today.';

  @override
  String get errorSi012 =>
      'That pickup window clashes with orders already reserved.';

  @override
  String get errorSi013 => 'This restaurant is suspended.';

  @override
  String errorSi013Contact(String email) {
    return 'This restaurant is suspended. Contact $email.';
  }

  @override
  String get errorSi020 => 'The discount is below the minimum.';

  @override
  String get errorSi021 =>
      'The quantity cannot be lower than the amount already reserved.';

  @override
  String errorSi021Reserved(int reserved) {
    return 'The quantity cannot be lower than the $reserved already reserved.';
  }

  @override
  String get errorSi030 =>
      'That code does not match an order at this restaurant.';

  @override
  String get errorSi031 => 'This order was already collected.';

  @override
  String get errorSi032 => 'This order has expired.';

  @override
  String get errorSi033 => 'This order was cancelled.';

  @override
  String get errorSi034 => 'Pickup has not started yet.';

  @override
  String get errorSi040 => 'Choose a reason for the cancellation.';

  @override
  String get errorSi041 => 'This order cannot be cancelled.';

  @override
  String get errorSi050 => 'Too many codes were sent. Try again later.';

  @override
  String errorSi050Wait(int minutes) {
    return 'Too many codes were sent. Try again in $minutes minutes.';
  }

  @override
  String get errorSi051 =>
      'Add your name, phone, and acceptance of the terms to continue.';

  @override
  String get errorSi060 =>
      'This account cannot be deleted while an order is still reserved.';

  @override
  String get errorSi070 =>
      'An admin cannot reset or deactivate their own account.';

  @override
  String get walkthrough1Title => 'Save food, Save money!';

  @override
  String get walkthrough1Body =>
      'Join many others in reducing food waste as food venues around Abu Dhabi share their surplus food every evening at a discounted rate! Why let good food go to waste?';

  @override
  String get walkthrough2Title => 'Make your reservation';

  @override
  String get walkthrough2Body =>
      'Select what you want and get a unique pick up code, in just a few taps!';

  @override
  String get walkthrough3Title => 'Collect and pay at location';

  @override
  String get walkthrough3Body =>
      'Simply go to your selected food venue, show your unique code between the pick up time & collect your order!';

  @override
  String get actionSkip => 'Skip';

  @override
  String get actionNext => 'Next';

  @override
  String get actionGetStarted => 'Get started';

  @override
  String get locationSheetTitle => 'See food venues near you.';

  @override
  String get locationSheetBody =>
      'Allow location to see all the food venues with discounts available today!';

  @override
  String get actionAllowLocation => 'Allow location';

  @override
  String get actionChooseAreaInstead => 'Choose area instead';

  @override
  String get chooseAreaTitle => 'Choose your area';

  @override
  String get searchAreasHint => 'Search areas';

  @override
  String get areasHeader => 'Abu Dhabi areas';

  @override
  String get actionShowRestaurants => 'Show restaurants';

  @override
  String get currentLocation => 'Current location';

  @override
  String get areasLoadError => 'The area list could not be loaded.';

  @override
  String get actionContinue => 'Continue';

  @override
  String get actionContinueWithEmail => 'Continue with email';

  @override
  String get actionSendCode => 'Send code';

  @override
  String get actionResendCode => 'Resend code';

  @override
  String get signUpGateTitle => 'Log in or sign up to reserve.';

  @override
  String get signUpGateBody =>
      'You can keep browsing as a guest. Enter your email to reserve; there\'s no password.';

  @override
  String get emailAppBar => 'Log in or sign up';

  @override
  String get emailHeading => 'What\'s your email?';

  @override
  String get emailBody =>
      'We\'ll send a 6-digit code. New to Save It? You\'ll add your details next.';

  @override
  String get fieldEmail => 'Email';

  @override
  String get codeAppBar => 'Enter code';

  @override
  String get codeHeading => 'Check your email.';

  @override
  String codeSentTo(String maskedEmail) {
    return 'Code sent to $maskedEmail.';
  }

  @override
  String get codeDidntGetIt => 'Didn\'t get it?';

  @override
  String get codeErrorTitle => 'Incorrect or expired code';

  @override
  String get codeErrorBody => 'Check the code or request a new one.';

  @override
  String codeResendWait(int minutes) {
    return 'Try again in $minutes min';
  }

  @override
  String get codeResendLimit => 'You can request up to 3 codes per hour.';

  @override
  String get profileSetupAppBar => 'Create your account';

  @override
  String get profileSetupHeading => 'Almost done.';

  @override
  String get profileSetupBody => 'Tell us who\'s collecting the food.';

  @override
  String get verified => 'Verified';

  @override
  String get fieldFullName => 'Full name';

  @override
  String get fieldPhone => 'Phone';

  @override
  String get phonePrefix => '+971';

  @override
  String get phoneInvalid => 'Enter a valid phone number.';

  @override
  String get termsAgreePrefix => 'I agree to the';

  @override
  String get termsAgreeJoin => 'and';

  @override
  String get termsLink => 'Terms and Conditions';

  @override
  String get privacyLink => 'Privacy Policy';

  @override
  String get guestTitle => 'You\'re browsing as a guest.';

  @override
  String get guestBody =>
      'Log in or sign up to reserve food and see your orders.';

  @override
  String get guestOrdersTitle => 'Log in or sign up to see your orders';

  @override
  String get guestOrdersBody =>
      'Your reservations and pickup passes appear here.';

  @override
  String get actionLogOut => 'Log out';

  @override
  String get actionEdit => 'Edit';

  @override
  String get editProfileTitle => 'Edit profile';

  @override
  String get emailLocked => 'Your email is your login and can\'t be changed.';

  @override
  String get actionSaveChanges => 'Save changes';

  @override
  String get support => 'Support';
}
