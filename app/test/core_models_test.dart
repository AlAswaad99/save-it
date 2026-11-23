import 'package:flutter_test/flutter_test.dart';
import 'package:save_it/core/models/core_models.dart';
import 'package:save_it/core/models/json_converters.dart';

void main() {
  test('area GeoJSON keeps longitude first', () {
    final area = Area.fromJson({
      'id': 7,
      'name': 'Al Marina',
      'sort': 7,
      'location': {
        'type': 'Point',
        'coordinates': [54.32143, 24.47604],
      },
    });

    expect(area.location.latitude, 24.47604);
    expect(area.location.longitude, 54.32143);
    expect(area.toJson()['location'], {
      'type': 'Point',
      'coordinates': [54.32143, 24.47604],
    });
  });

  test('WKT point parses longitude then latitude', () {
    final point = geoPointFromJson('POINT(54.34019 24.47419)');
    expect(point, const GeoPoint(latitude: 24.47419, longitude: 54.34019));
  });

  test('listing money stays text when the API sends a number', () {
    final listing = Listing.fromJson({
      'id': 'c0000000-0000-4000-8000-000000000011',
      'restaurant_id': 'b0000000-0000-4000-8000-000000000011',
      'date': '2026-11-23',
      'name': 'Grilled chicken plate',
      'category_id': 2,
      'original_price': 40,
      'discounted_price': '16.00',
      'quantity': 4,
      'quantity_reserved': 0,
      'photo_path': null,
      'status': 'live',
      'copied_from_id': null,
      'created_at': '2026-11-23T08:00:00Z',
      'updated_at': '2026-11-23T08:00:00Z',
    });

    expect(listing.originalPrice, '40');
    expect(listing.discountedPrice, '16.00');
    expect(listing.status, ListingStatus.live);
    expect(listing.toJson()['discounted_price'], '16.00');
    expect(listing.toJson()['status'], 'live');
  });

  test('order JSON uses the database names', () {
    final order = Order.fromJson({
      'id': 'e0000000-0000-4000-8000-000000000001',
      'code': 'ABCD23',
      'customer_id': 'a0000000-0000-4000-8000-000000000002',
      'customer_name': 'Dev Customer',
      'restaurant_id': 'b0000000-0000-4000-8000-000000000011',
      'pickup_window_id': 'd0000000-0000-4000-8000-000000000011',
      'status': 'cancelled',
      'total': '16.00',
      'commission_rate': '0.4000',
      'commission_amount': '6.40',
      'cancel_reason': 'closing_early',
      'cancel_note': null,
      'cancelled_by': null,
      'reminder_sent_at': null,
      'reserved_at': '2026-11-23T12:00:00Z',
      'collected_at': null,
      'cancelled_at': '2026-11-23T12:30:00Z',
      'expired_at': null,
    });

    expect(order.cancelReason, CancelReason.closingEarly);
    expect(order.commissionRate, '0.4000');
    expect(order.toJson()['cancel_reason'], 'closing_early');
    expect(order.toJson()['customer_name'], 'Dev Customer');
  });

  test('public settings omit nothing the guest RPC returns', () {
    final settings = PublicSettings.fromJson({
      'currency': 'AED',
      'max_units_per_listing': 2,
      'max_active_orders': 2,
      'support_email': 'contact@arisehub.org',
      'prices_include_vat': true,
      'search_radius_m': 10000,
    });

    expect(settings.currency, 'AED');
    expect(settings.pricesIncludeVat, isTrue);
    expect(settings.toJson()['support_email'], 'contact@arisehub.org');
    expect(settings.toJson().containsKey('commission_rate'), isFalse);
  });
}
