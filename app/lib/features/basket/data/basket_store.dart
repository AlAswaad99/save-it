import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:save_it/features/basket/domain/basket.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class BasketStore {
  Future<Basket> read();

  Future<void> write(Basket basket);
}

class PreferencesBasketStore implements BasketStore {
  static const key = 'basket';

  @override
  Future<Basket> read() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(key);
    if (raw == null) {
      return const Basket.empty();
    }
    final decoded = jsonDecode(raw);
    if (decoded is! Map) {
      return const Basket.empty();
    }
    return Basket.fromJson(decoded.cast<String, Object?>());
  }

  @override
  Future<void> write(Basket basket) async {
    final prefs = await SharedPreferences.getInstance();
    if (basket.isEmpty) {
      await prefs.remove(key);
      return;
    }
    await prefs.setString(key, jsonEncode(basket.toJson()));
  }
}

class MemoryBasketStore implements BasketStore {
  Basket basket = const Basket.empty();

  @override
  Future<Basket> read() async => basket;

  @override
  Future<void> write(Basket basket) async {
    this.basket = basket;
  }
}

final basketStoreProvider = Provider<BasketStore>(
  (ref) => PreferencesBasketStore(),
);

class BasketController extends AsyncNotifier<Basket> {
  @override
  Future<Basket> build() => ref.watch(basketStoreProvider).read();

  Future<void> save(Basket basket) async {
    await ref.read(basketStoreProvider).write(basket);
    state = AsyncData(basket);
  }
}

final basketProvider = AsyncNotifierProvider<BasketController, Basket>(
  BasketController.new,
);
