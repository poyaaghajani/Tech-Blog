import 'package:flutter/material.dart';
import 'package:tech_blog/component/my_colors.dart';

PreferredSize myAppBar(TextTheme textTheme, String title) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(60),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Center(
            child: Text(
              title,
              style: textTheme.titleSmall,
            ),
          ),
        ],
        leading: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: SolidColors.primaryColor.withOpacity(0.7),
          ),
          child: const Icon(Icons.keyboard_arrow_right),
        ),
      ),
    ),
  );
}
