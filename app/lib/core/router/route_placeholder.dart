import 'package:flutter/material.dart';

/// A named screen until the feature task fills it in.
class RoutePlaceholder extends StatelessWidget {
  const RoutePlaceholder({
    required this.screenKey,
    required this.title,
    super.key,
  });

  final Key screenKey;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(title, key: screenKey),
      ),
    );
  }
}
