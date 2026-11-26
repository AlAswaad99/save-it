class AccountProfile {
  const AccountProfile({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.supportEmail,
  });

  final String fullName;
  final String email;
  final String phone;
  final String supportEmail;

  AccountProfile copyWith({String? fullName, String? phone}) {
    return AccountProfile(
      fullName: fullName ?? this.fullName,
      email: email,
      phone: phone ?? this.phone,
      supportEmail: supportEmail,
    );
  }
}

/// `+971501234567` shown as `+971 50 123 4567`.
String formatPhone(String phone) {
  if (!phone.startsWith('+971') || phone.length != 13) {
    return phone;
  }
  final national = phone.substring(4);
  return '+971 ${national.substring(0, 2)} ${national.substring(2, 5)} ${national.substring(5)}';
}

String nationalDigits(String phone) {
  final digits = phone.replaceAll(RegExp(r'\D'), '');
  if (digits.startsWith('971')) {
    return digits.substring(3);
  }
  return digits;
}

String initials(String name) {
  final parts = name
      .trim()
      .split(RegExp(r'\s+'))
      .where((part) => part.isNotEmpty)
      .toList();
  if (parts.isEmpty) {
    return '';
  }
  if (parts.length == 1) {
    return parts.first.substring(0, 1).toUpperCase();
  }
  return '${parts.first.substring(0, 1)}${parts.last.substring(0, 1)}'
      .toUpperCase();
}
