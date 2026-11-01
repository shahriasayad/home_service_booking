import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../data/models/worker_model.dart';
import '../theme/app_colors.dart';
import '../theme/app_sizes.dart';

class WorkerCard extends StatelessWidget {
  final WorkerModel worker;
  final VoidCallback onTap;

  const WorkerCard({
    super.key,
    required this.worker,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: AppSizes.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius:
        BorderRadius.circular(AppSizes.cardRadius),
      ),
      child: InkWell(
        borderRadius:
        BorderRadius.circular(AppSizes.cardRadius),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.md),
          child: Row(
            children: [

              CircleAvatar(
                radius: AppSizes.avatarMd,
                backgroundImage: AssetImage(worker.image),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [

                    Text(
                      worker.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(worker.profession),

                    const SizedBox(height: 5),

                    Text(
                      "${worker.experience} Experience",
                    ),

                    const SizedBox(height: 6),

                    RatingBarIndicator(
                      rating: worker.rating,
                      itemCount: 5,
                      itemSize: 18,
                      itemBuilder: (_, __) =>
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                    ),
                  ],
                ),
              ),

              const Icon(
                Icons.arrow_forward_ios,
                size: 18,
                color: AppColors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}