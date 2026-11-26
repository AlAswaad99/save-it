import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Whether this install has already passed the walkthrough.
abstract class WalkthroughStore {
  Future<bool> readSeen();

  Future<void> writeSeen();
}

class PreferencesWalkthroughStore implements WalkthroughStore {
  static const seenKey = 'walkthrough_seen';

  @override
  Future<bool> readSeen() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(seenKey) ?? false;
  }

  @override
  Future<void> writeSeen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(seenKey, true);
  }
}

/// In-memory stand-in for widget tests.
class MemoryWalkthroughStore implements WalkthroughStore {
  MemoryWalkthroughStore({this.seen = false});

  bool seen;

  @override
  Future<bool> readSeen() async => seen;

  @override
  Future<void> writeSeen() async {
    seen = true;
  }
}

final walkthroughStoreProvider = Provider<WalkthroughStore>(
  (ref) => PreferencesWalkthroughStore(),
);

class WalkthroughSeen extends AsyncNotifier<bool> {
  @override
  Future<bool> build() => ref.watch(walkthroughStoreProvider).readSeen();

  Future<void> markSeen() async {
    await ref.read(walkthroughStoreProvider).writeSeen();
    state = const AsyncData(true);
  }
}

final walkthroughSeenProvider =
    AsyncNotifierProvider<WalkthroughSeen, bool>(WalkthroughSeen.new);
