import 'package:flutter/material.dart';

import '../data/models/category_model.dart';
import '../theme/app_colors.dart';
import '../theme/app_sizes.dart';

class CategoryCard extends StatelessWidget {
  final CategoryModel category;
  final VoidCallback onTap;
  final bool isSelected;

  const CategoryCard({
    super.key,
    required this.category,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return InkWell(
      borderRadius: BorderRadius.circular(AppSizes.cardRadius),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSizes.sm),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: isDark ? 0.28 : 0.12)
              : theme.cardColor,
          borderRadius: BorderRadius.circular(AppSizes.cardRadius),
          border: Border.all(
            color: isSelected ? AppColors.primary : theme.dividerColor,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              category.image,
              height: AppSizes.categoryImage,
              width: AppSizes.categoryImage,
              fit: BoxFit.contain,
              errorBuilder: (_, _, _) => const Icon(
                Icons.home_repair_service,
                size: AppSizes.categoryImage,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              category.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: isSelected
                    ? (isDark ? AppColors.secondary : AppColors.primary)
                    : theme.colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
