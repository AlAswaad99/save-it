import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:save_it/features/location/domain/search_origin.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class OriginStore {
  Future<SearchOrigin?> read();

  Future<void> write(SearchOrigin origin);
}

class PreferencesOriginStore implements OriginStore {
  static const key = 'search_origin';

  @override
  Future<SearchOrigin?> read() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(key);
    if (raw == null) {
      return null;
    }
    final decoded = jsonDecode(raw);
    if (decoded is! Map) {
      return null;
    }
    return SearchOrigin.fromJson(decoded.cast<String, Object?>());
  }

  @override
  Future<void> write(SearchOrigin origin) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, jsonEncode(origin.toJson()));
  }
}

class MemoryOriginStore implements OriginStore {
  SearchOrigin? origin;

  @override
  Future<SearchOrigin?> read() async => origin;

  @override
  Future<void> write(SearchOrigin origin) async {
    this.origin = origin;
  }
}

final originStoreProvider = Provider<OriginStore>(
  (ref) => PreferencesOriginStore(),
);

typedef Now = DateTime Function();

final clockProvider = Provider<Now>((ref) => DateTime.now);

class SearchOriginController extends AsyncNotifier<SearchOrigin?> {
  @override
  Future<SearchOrigin?> build() => ref.watch(originStoreProvider).read();

  Future<void> save(SearchOrigin origin) async {
    await ref.read(originStoreProvider).write(origin);
    state = AsyncData(origin);
  }
}

final searchOriginProvider =
    AsyncNotifierProvider<SearchOriginController, SearchOrigin?>(
      SearchOriginController.new,
    );
