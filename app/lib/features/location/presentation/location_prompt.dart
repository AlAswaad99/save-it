import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Set when Skip or Get started should open the location sheet over Explore.
class LocationPrompt extends Notifier<bool> {
  @override
  bool build() => false;

  void request() => state = true;

  void clear() => state = false;
}

final locationPromptProvider = NotifierProvider<LocationPrompt, bool>(
  LocationPrompt.new,
);
