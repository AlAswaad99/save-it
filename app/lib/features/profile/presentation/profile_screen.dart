import 'package:flutter/material.dart';
import 'package:save_it/core/widgets/placeholder_body.dart';
import 'package:save_it/l10n/context_l10n.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.tabProfile)),
      body: PlaceholderBody(message: l10n.profilePlaceholder),
    );
  }
}
