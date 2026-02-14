import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';

class RestaurantShimmerCard extends StatelessWidget {
  const RestaurantShimmerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image Placeholder
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(12),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name Placeholder
                  Container(
                    height: 14,
                    width: 180,
                    color: Colors.grey.shade300,
                  ),
                  const SizedBox(height: 8),

                  // Cuisine Placeholder
                  Container(
                    height: 12,
                    width: 120,
                    color: Colors.grey.shade300,
                  ),
                  const SizedBox(height: 12),

                  // Rating + Time Row
                  Row(
                    children: [
                      Container(
                        height: 30,
                        width: 70,
                        color: Colors.grey.shade300,
                      ),
                      const SizedBox(width: 12),
                      Container(
                        height: 30,
                        width: 70,
                        color: Colors.grey.shade300,
                      ),
                      const SizedBox(width: 12),
                      Container(
                        height: 30,
                        width: 70,
                        color: Colors.grey.shade300,
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
