import 'package:flutter/material.dart';
import 'package:newdow_customer/utils/apptheme.dart';

class SafeNetworkImage extends StatelessWidget {
  final String url;
  final double width;
  final double height;
  final BoxFit fit;

  const SafeNetworkImage({
    Key? key,
    required this.url,
    this.width = 100,
    this.height = 100,
    this.fit = BoxFit.cover,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("image search $url");
    return Image.network(
      url..replaceAll(RegExp(r'[\[\]]'), ''),
      width: width,
      height: height,
      fit: fit,

      /// Show loader while image is loading
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                  (loadingProgress.expectedTotalBytes ?? 1)
                  : null,
            ),
          ),
        );
      },

      /// Show fallback when image fails
      errorBuilder: (context, error, stackTrace) {
        print(error);
        return
            Container(
              width: width,
              height: height,
              color: Colors.grey.shade300,
              child: Icon(Icons.broken_image, color: Colors.grey, size: 32),
            );
      },
    );
  }
}
