import 'package:flutter/material.dart';

import '../data/models/payment_model.dart';

class PaymentTile extends StatelessWidget {
  final PaymentModel payment;
  final bool selected;
  final VoidCallback onTap;

  const PaymentTile({
    super.key,
    required this.payment,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return RadioListTile<bool>(
      value: true,
      groupValue: selected,
      onChanged: (_) => onTap(),
      title: Text(payment.title),
      secondary: Image.asset(
        payment.icon,
        width: 30,
        height: 30,
      ),
    );
  }
}