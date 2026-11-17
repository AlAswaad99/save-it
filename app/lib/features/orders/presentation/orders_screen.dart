import 'package:flutter/material.dart';
import 'package:save_it/core/widgets/placeholder_body.dart';
import 'package:save_it/l10n/context_l10n.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.tabOrders)),
      body: PlaceholderBody(message: l10n.ordersPlaceholder),
    );
  }
}
