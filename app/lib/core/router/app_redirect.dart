import 'package:save_it/core/session/app_session.dart';

/// Where the splash screen goes once it has been seen.
String homeFor(AppSession session, {required bool walkthroughSeen}) {
  if (session.role == AppRole.restaurant) {
    return session.restaurantTermsAccepted
        ? '/business/today'
        : '/business/terms';
  }
  if (!walkthroughSeen) {
    return '/welcome';
  }
  return '/explore';
}

/// Redirect rules from `docs/04-mobile-app.md` §4.
///
/// `/business/login` stays reachable for a guest or a customer. It is the
/// entry screen, not Business mode. A customer session is sent away from
/// every other `/business` route. A restaurant session is sent into
/// `/business`, and to `/business/terms` until the terms are accepted.
String? resolveAppRedirect(
  Uri uri,
  AppSession session, {
  required bool walkthroughSeen,
}) {
  final path = _path(uri);
  if (path == '/splash') {
    return null;
  }

  if (session.role == AppRole.restaurant) {
    return _restaurantRedirect(path, session.restaurantTermsAccepted);
  }

  if (!walkthroughSeen && path != '/welcome') {
    return '/welcome';
  }
  if (walkthroughSeen && path == '/welcome') {
    return '/explore';
  }

  if (_isBusinessMode(path)) {
    return session.role == AppRole.guest ? '/business/login' : '/explore';
  }

  final from = _returnPath(uri.queryParameters['from'], session);

  if (session.role == AppRole.guest) {
    if (path == '/auth/profile') {
      return _same(uri, _withFrom('/auth/email', from));
    }
    if (_needsAccount(path)) {
      return _same(uri, _withFrom('/auth/email', path));
    }
    return null;
  }

  if (!session.profileComplete) {
    if (path == '/auth/profile') {
      return null;
    }
    if (path.startsWith('/auth/') || _needsAccount(path)) {
      final origin = path.startsWith('/auth/') ? from : path;
      return _same(uri, _withFrom('/auth/profile', origin));
    }
    return null;
  }

  if (path.startsWith('/auth/')) {
    return _same(uri, from ?? '/explore');
  }
  return null;
}

String? _restaurantRedirect(String path, bool termsAccepted) {
  if (!termsAccepted) {
    return path == '/business/terms' ? null : '/business/terms';
  }
  if (path == '/business/login' ||
      path == '/business/terms' ||
      !_isBusinessMode(path)) {
    return '/business/today';
  }
  return null;
}

bool _needsAccount(String path) {
  return path == '/checkout' ||
      path == '/profile/edit' ||
      (path.startsWith('/orders/') && path != '/orders');
}

bool _isBusinessMode(String path) {
  return path == '/business' ||
      (path.startsWith('/business/') && path != '/business/login');
}

String? _returnPath(String? value, AppSession session) {
  final path = _safePath(value);
  if (path == null) {
    return null;
  }
  if (session.role != AppRole.restaurant && _isBusinessMode(path)) {
    return '/explore';
  }
  return path;
}

String? _safePath(String? value) {
  if (value == null || value.isEmpty) {
    return null;
  }
  final parsed = Uri.tryParse(value);
  if (parsed == null || parsed.hasScheme || parsed.host.isNotEmpty) {
    return null;
  }
  if (!value.startsWith('/') || value.startsWith('//')) {
    return null;
  }
  return _path(parsed);
}

String _withFrom(String path, String? from) {
  if (from == null || from == path) {
    return path;
  }
  return '$path?from=${Uri.encodeQueryComponent(from)}';
}

String? _same(Uri current, String target) {
  final next = Uri.parse(target);
  final samePath = _path(current) == _path(next);
  final sameFrom =
      current.queryParameters['from'] == next.queryParameters['from'];
  if (samePath && sameFrom) {
    return null;
  }
  return target;
}

String _path(Uri uri) {
  final path = uri.path;
  if (path.length > 1 && path.endsWith('/')) {
    return path.substring(0, path.length - 1);
  }
  if (path.isEmpty) {
    return '/';
  }
  return path;
}
