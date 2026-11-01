import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class LoadingWidget extends StatelessWidget {
  final double size;
  final Color? color;
  final String? message;

  const LoadingWidget({
    super.key,
    this.size = 35,
    this.color,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: size,
            width: size,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              color: color ?? AppColors.primary,
            ),
          ),

          if (message != null) ...[
            const SizedBox(height: 15),
            Text(
              message!,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.grey,
              ),
            ),
          ],
        ],
      ),
    );
  }
}