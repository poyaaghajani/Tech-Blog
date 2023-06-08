import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_blog/gen/assets.gen.dart';

class SeeMoreWidget extends StatelessWidget {
  const SeeMoreWidget({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    var bodyMargin = Get.width / 28;
    var textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.only(right: bodyMargin),
        child: Row(
          children: [
            Assets.icons.bluePen.image(height: 20),
            const SizedBox(width: 8),
            Text(
              text,
              style: textTheme.displaySmall,
            ),
          ],
        ),
      ),
    );
  }
}
