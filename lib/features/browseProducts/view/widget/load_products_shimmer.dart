import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:newdow_customer/utils/apptheme.dart';
import 'package:newdow_customer/utils/getSize.dart';

class ProductGridShimmer extends StatelessWidget {
  final int itemCount;

  const ProductGridShimmer({
    Key? key,
    this.itemCount = 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate:
      const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.88,
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return  _ShimmerProductCard();
      },
    );
  }
}


class _ShimmerProductCard extends StatelessWidget {
  const _ShimmerProductCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white, // Main container stays white
        ),
        child: Column(
          children: [
            // Image Placeholder
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                alignment: Alignment.topCenter,
                height: 0.14.toHeightPercent(),
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  child: Container(
                    width: double.infinity,
                    color: Colors.white, // <<< No grey
                  ),
                ),
              ),
            ),

            // Product Info Placeholders
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Product Name Skeleton
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          height: 16,
                          decoration: BoxDecoration(
                            color: Colors.white,      // <<< No grey
                            borderRadius: BorderRadius.circular(4),
                          ),
                          margin: const EdgeInsets.only(bottom: 8),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 14,
                          decoration: BoxDecoration(
                            color: Colors.white,      // <<< No grey
                            borderRadius: BorderRadius.circular(4),
                          ),
                          margin: const EdgeInsets.only(bottom: 8),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Price Row Skeleton
                  Row(
                    spacing: 8,
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          height: 18,
                          width: 70,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                      Container(
                        height: 14,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Quantity Control Skeleton
                  Container(
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

