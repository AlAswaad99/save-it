import 'package:flutter/material.dart';

import 'package:save_it/core/theme/app_colors.dart';

class SaveItTextField extends StatelessWidget {
  const SaveItTextField({
    required this.label,
    this.hint,
    this.errorText,
    this.enabled = true,
    super.key,
  });

  final String label;
  final String? hint;
  final String? errorText;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: enabled,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        errorText: errorText,
        filled: true,
        fillColor: enabled ? AppColors.surface : AppColors.disabled,
      ),
    );
  }
}
