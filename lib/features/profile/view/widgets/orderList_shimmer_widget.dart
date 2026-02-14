import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newdow_customer/utils/getSize.dart';
import 'package:shimmer/shimmer.dart';

class OrderlistShimmerWidget extends StatelessWidget {
  const OrderlistShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ordersShimmer();
  }

  Widget ordersShimmer() {
    return Container(
      height: 0.8.toHeightPercent(),
      child: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: 6, // you can increase if you want more shimmer items
        separatorBuilder: (_, __) =>
            Divider(height: 5, color: Colors.grey.withOpacity(0.3)),
        itemBuilder: (_, __) => shimmerOrderCard(),
      ),
    );
  }
  Widget shimmerOrderCard() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          // IMAGE SHIMMER
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 0.12.toHeightPercent(),
              width: 0.25.toWidthPercent(),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),

          const SizedBox(width: 12),

          // TEXT SHIMMER
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                shimmerLine(width: 140),
                const SizedBox(height: 8),
                shimmerLine(width: 100),
                const SizedBox(height: 8),
                shimmerLine(width: 80),
              ],
            ),
          ),

          const SizedBox(width: 10),

          // RE-ORDER BUTTON SHIMMER
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: 70,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget shimmerLine({required double width}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width,
        height: 12,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }

}
