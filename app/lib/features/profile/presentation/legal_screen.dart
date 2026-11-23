import 'package:flutter/material.dart';

/// Terms and privacy stay blank until Arise sends the documents.
class LegalScreen extends StatelessWidget {
  const LegalScreen({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text(title)));
  }
}
