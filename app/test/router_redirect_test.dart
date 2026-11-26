import 'package:flutter_test/flutter_test.dart';
import 'package:save_it/core/router/app_redirect.dart';
import 'package:save_it/core/session/app_session.dart';

void main() {
  const guest = AppSession.guest();
  const incomplete = AppSession.customer(profileComplete: false);
  const customer = AppSession.customer(profileComplete: true);
  const restaurant = AppSession.restaurant(restaurantTermsAccepted: true);
  const pendingTerms = AppSession.restaurant(restaurantTermsAccepted: false);

  String? go(
    String location,
    AppSession session, {
    bool walkthroughSeen = true,
  }) {
    return resolveAppRedirect(
      Uri.parse(location),
      session,
      walkthroughSeen: walkthroughSeen,
    );
  }

  test('splash stays so C-01 can show, then home follows the role', () {
    expect(go('/splash', guest), isNull);
    expect(homeFor(guest, walkthroughSeen: true), '/explore');
    expect(homeFor(customer, walkthroughSeen: true), '/explore');
    expect(homeFor(incomplete, walkthroughSeen: true), '/explore');
    expect(homeFor(restaurant, walkthroughSeen: false), '/business/today');
    expect(homeFor(pendingTerms, walkthroughSeen: false), '/business/terms');
    expect(homeFor(guest, walkthroughSeen: false), '/welcome');
  });

  test('a restaurant is kept inside business mode', () {
    expect(go('/explore', restaurant), '/business/today');
    expect(go('/orders', restaurant), '/business/today');
    expect(go('/profile', restaurant), '/business/today');
    expect(go('/auth/email', restaurant), '/business/today');
    expect(go('/business/login', restaurant), '/business/today');
    expect(go('/business/terms', restaurant), '/business/today');
    expect(go('/business/today', restaurant), isNull);
    expect(go('/checkout', restaurant), '/business/today');
  });

  test('a restaurant that has not accepted the terms is sent to terms', () {
    expect(go('/business/today', pendingTerms), '/business/terms');
    expect(go('/explore', pendingTerms), '/business/terms');
    expect(go('/business/login', pendingTerms), '/business/terms');
    expect(go('/business/terms', pendingTerms), isNull);
  });

  test('a customer is never sent into business mode', () {
    expect(go('/business/today', customer), '/explore');
    expect(go('/business/terms', customer), '/explore');
    expect(go('/business/today', incomplete), '/explore');
    expect(go('/business/login', customer), isNull);
    expect(go('/business/login', guest), isNull);
    expect(go('/explore', customer), isNull);
  });

  test('an incomplete profile is sent to complete it before account routes', () {
    expect(go('/explore', incomplete), isNull);
    expect(go('/orders', incomplete), isNull);
    expect(go('/profile', incomplete), isNull);
    expect(go('/basket', incomplete), isNull);
    expect(
      go('/checkout', incomplete),
      '/auth/profile?from=%2Fcheckout',
    );
    expect(
      go('/orders/order-1', incomplete),
      '/auth/profile?from=%2Forders%2Forder-1',
    );
    expect(
      go('/profile/edit', incomplete),
      '/auth/profile?from=%2Fprofile%2Fedit',
    );
    expect(go('/auth/profile', incomplete), isNull);
    expect(
      go('/auth/email?from=%2Fcheckout', incomplete),
      '/auth/profile?from=%2Fcheckout',
    );
  });

  test('a guest is sent to email sign-in and comes back afterwards', () {
    expect(go('/orders', guest), isNull);
    expect(go('/profile', guest), isNull);
    expect(go('/checkout', guest), '/auth/email?from=%2Fcheckout');
    expect(go('/orders/order-1', guest), '/auth/email?from=%2Forders%2Forder-1');
    expect(go('/auth/profile', guest), '/auth/email');
    expect(go('/auth/email?from=%2Fcheckout', guest), isNull);
    expect(go('/auth/code?from=%2Fcheckout', customer), '/checkout');
    expect(go('/auth/profile?from=%2Forders', customer), '/orders');
    expect(go('/auth/email', customer), '/explore');
  });

  test('a customer return path cannot land in business mode', () {
    expect(
      go('/auth/code?from=%2Fbusiness%2Ftoday', customer),
      '/explore',
    );
  });

  test('a guest who opens a business screen is sent to restaurant login', () {
    expect(go('/business/today', guest), '/business/login');
    expect(go('/business/terms', guest), '/business/login');
  });

  test('the walkthrough is first launch only', () {
    expect(go('/explore', guest, walkthroughSeen: false), '/welcome');
    expect(go('/welcome', guest, walkthroughSeen: false), isNull);
    expect(go('/welcome', guest), '/explore');
    expect(go('/explore', restaurant, walkthroughSeen: false), '/business/today');
  });

  test('an external return path is ignored', () {
    expect(
      go('/auth/email?from=https%3A%2F%2Fexample.com', customer),
      '/explore',
    );
  });
}
