import 'package:flutter/material.dart';
import 'package:tech_blog/component/my_colors.dart';
import 'package:tech_blog/utils/devise_size.dart';

class TechDivider extends StatelessWidget {
  const TechDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: SolidColors.dividerColor,
      height: 1,
      thickness: 1.5,
      indent: DeviseSize.getWidth(context) / 5,
      endIndent: DeviseSize.getWidth(context) / 5,
    );
  }
}
