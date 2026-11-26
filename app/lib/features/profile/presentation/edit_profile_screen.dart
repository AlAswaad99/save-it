import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:save_it/core/errors/app_exception.dart';
import 'package:save_it/core/theme/app_spacing.dart';
import 'package:save_it/core/widgets/save_it_button.dart';
import 'package:save_it/core/widgets/save_it_text_field.dart';
import 'package:save_it/features/profile/data/account_directory.dart';
import 'package:save_it/features/profile/domain/account_profile.dart';
import 'package:save_it/l10n/context_l10n.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _email = TextEditingController();
  var _ready = false;
  var _busy = false;
  String? _error;

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    _email.dispose();
    super.dispose();
  }

  void _fill(AccountProfile profile) {
    if (_ready) {
      return;
    }
    _name.text = profile.fullName;
    _phone.text = nationalDigits(profile.phone);
    _email.text = profile.email;
    _ready = true;
  }

  String? get _e164 {
    final digits = _phone.text.replaceAll(RegExp(r'\D'), '');
    if (digits.isEmpty) {
      return null;
    }
    final phone = '+971$digits';
    if (!RegExp(r'^\+[1-9][0-9]{6,14}$').hasMatch(phone)) {
      return null;
    }
    return phone;
  }

  Future<void> _save() async {
    final phone = _e164;
    final name = _name.text.trim();
    if (phone == null || name.isEmpty) {
      setState(() => _error = context.l10n.phoneInvalid);
      return;
    }
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await ref
          .read(accountProfileProvider.notifier)
          .save(fullName: name, phone: phone);
      if (mounted) {
        context.pop();
      }
    } on AppException {
      if (mounted) {
        setState(() => _error = context.l10n.errorSi001);
      }
    } finally {
      if (mounted) {
        setState(() => _busy = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final account = ref.watch(accountProfileProvider);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.editProfileTitle)),
      body: account.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text(l10n.errorSi001)),
        data: (profile) {
          _fill(profile);
          return Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SaveItTextField(label: l10n.fieldFullName, controller: _name),
                const SizedBox(height: AppSpacing.md),
                Text(l10n.phonePrefix),
                const SizedBox(height: AppSpacing.xs),
                SaveItTextField(
                  label: l10n.fieldPhone,
                  controller: _phone,
                  keyboardType: TextInputType.phone,
                  errorText: _error,
                ),
                const SizedBox(height: AppSpacing.md),
                SaveItTextField(
                  key: const Key('email-locked'),
                  label: l10n.fieldEmail,
                  controller: _email,
                  readOnly: true,
                  enabled: false,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(l10n.emailLocked),
                const Spacer(),
                SaveItButton(
                  label: l10n.actionSaveChanges,
                  isLoading: _busy,
                  onPressed: _busy ? null : _save,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
