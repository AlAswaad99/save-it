/// Displays an AED amount copied onto an order or listing.
///
/// The "incl. VAT" suffix is added later, when `prices_include_vat` is read
/// from `app_settings`.
String formatAed(num amount) {
  return 'AED ${amount.toStringAsFixed(2)}';
}
