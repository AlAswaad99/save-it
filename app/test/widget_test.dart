import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:save_it/main.dart';

void main() {
  testWidgets('guest shell opens on Explore', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: SaveItApp()));
    expect(find.text('Explore'), findsWidgets);
    expect(find.text('Nearby surplus will show up here.'), findsOneWidget);
  });
}
