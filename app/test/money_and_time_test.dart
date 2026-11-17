import 'package:flutter_test/flutter_test.dart';
import 'package:save_it/core/utils/dubai_time.dart';
import 'package:save_it/core/utils/money.dart';

void main() {
  test('formats AED with two decimals', () {
    expect(formatAed(15), 'AED 15.00');
  });

  test('formats 24-hour Dubai time from a UTC instant', () {
    expect(formatDubaiTime(DateTime.utc(2026, 11, 18, 8, 5)), '12:05');
  });
}
