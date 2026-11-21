import 'package:flutter/material.dart';

import 'package:save_it/l10n/context_l10n.dart';

/// The supplied mark, `docs/businessrules-and-contents/La Logo.png`.
class SaveItLogo extends StatelessWidget {
  const SaveItLogo({super.key, this.height = 160});

  static const assetPath = 'assets/brand/La Logo.png';

  final double height;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: context.l10n.logoSemantics,
      image: true,
      child: ExcludeSemantics(
        child: Image.asset(assetPath, height: height, fit: BoxFit.contain),
      ),
    );
  }
}
