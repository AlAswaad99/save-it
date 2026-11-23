/// Who is using the app, as far as routing is concerned.
enum AppRole { guest, customer, restaurant }

/// The signed-in role and the two flags the router needs.
///
/// Profile completion is name, phone, and terms (C-13). Restaurant terms are
/// the first-login acceptance (B-02).
class AppSession {
  const AppSession({
    required this.role,
    required this.profileComplete,
    required this.restaurantTermsAccepted,
  });

  const AppSession.guest()
    : role = AppRole.guest,
      profileComplete = false,
      restaurantTermsAccepted = false;

  const AppSession.customer({required this.profileComplete})
    : role = AppRole.customer,
      restaurantTermsAccepted = false;

  const AppSession.restaurant({required this.restaurantTermsAccepted})
    : role = AppRole.restaurant,
      profileComplete = true;

  final AppRole role;
  final bool profileComplete;
  final bool restaurantTermsAccepted;
}
