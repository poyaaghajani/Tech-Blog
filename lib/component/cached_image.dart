import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tech_blog/component/my_colors.dart';

class CachedImage extends StatelessWidget {
  final String? imageUrl;
  final double? radius;
  const CachedImage({super.key, this.imageUrl, this.radius = 0});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius!),
      child: CachedNetworkImage(
        imageUrl: imageUrl ?? '',
        fit: BoxFit.cover,
        placeholder: (context, url) {
          return const SpinKitCircle(
            color: SolidColors.primaryColor,
          );
        },
        errorWidget: (context, url, error) {
          return Container(
            color: Colors.red,
          );
        },
      ),
    );
  }
}
