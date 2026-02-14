import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:newdow_customer/utils/getSize.dart';

class RecommendedRestaurantShimmer extends StatelessWidget {
  const RecommendedRestaurantShimmer({super.key});

  Widget _box({double? height, double? width, BorderRadius? radius}) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: radius ?? BorderRadius.circular(8),
      ),
    );
  }

  Widget _card() {
    return Container(
      width: 0.5.toWidthPercent(),
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _box(
            height: 0.16.toHeightPercent(),
            radius: BorderRadius.circular(12),
          ),
          const SizedBox(height: 12),
          _box(height: 14, width: 90),
          const SizedBox(height: 6),
          _box(height: 12, width: 120),
          const SizedBox(height: 6),
          _box(height: 12, width: 80),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0.3.toHeightPercent(),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: ListView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: List.generate(3, (_) => _card()),
        ),
      ),
    );
  }
}
