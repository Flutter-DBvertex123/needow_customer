 import 'package:flutter/material.dart';
import 'package:newdow_customer/utils/getSize.dart';
import 'package:shimmer/shimmer.dart';

class Productshemmer extends StatelessWidget {
  const Productshemmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 5, // Show 5 placeholder cards
        separatorBuilder: (context, index) => SizedBox(width: 14),
        itemBuilder: (context, index) {
          return Container(
            height: 0.12.toHeightPercent(),
            width: 0.12.toHeightPercent(),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey[300]!),
              color: Colors.grey[300],
            ),
            child: Column(
              children: [
                Container(
                  width: 0.8.toWidthPercent(),
                  height: 0.08.toHeightPercent(),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Container(
                  height: 0.03.toHeightPercent(),
                  color: Colors.grey[300],
                  alignment: Alignment.center,
                  width: double.infinity,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
