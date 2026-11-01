import 'package:flutter/material.dart';

import '../data/models/payment_model.dart';
import '../theme/app_colors.dart';
import '../theme/app_sizes.dart';

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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
        side: BorderSide(
          color: selected ? AppColors.primary : theme.dividerColor,
          width: selected ? 2 : 1,
        ),
      ),
      color: selected
          ? AppColors.primary.withValues(alpha: isDark ? 0.22 : 0.08)
          : theme.cardColor,
      child: ListTile(
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.cardRadius),
        ),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            payment.icon,
            width: 38,
            height: 38,
            fit: BoxFit.contain,
            errorBuilder: (_, _, _) => const Icon(
              Icons.payment,
              size: 32,
              color: AppColors.primary,
            ),
          ),
        ),
        title: Text(
          payment.title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: payment.subtitle.isNotEmpty
            ? Text(
                payment.subtitle,
                style: const TextStyle(fontSize: 12),
              )
            : null,
        trailing: Icon(
          selected ? Icons.radio_button_checked : Icons.radio_button_off,
          color: selected ? AppColors.primary : AppColors.grey,
        ),
      ),
    );
  }
}
