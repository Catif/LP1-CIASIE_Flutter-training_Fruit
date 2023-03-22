import 'package:flutter/material.dart';

class QuantityBadge extends StatelessWidget {
  const QuantityBadge({super.key, required this.quantity});

  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: Colors.red,
      label: Text(quantity.toString()),
    );
  }
}
