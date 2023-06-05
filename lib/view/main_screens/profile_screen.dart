import 'package:flutter/material.dart';
import 'package:tech_blog/component/tech_divider.dart';
import 'package:tech_blog/component/my_colors.dart';
import 'package:tech_blog/component/my_strings.dart';
import 'package:tech_blog/gen/assets.gen.dart';
import 'package:tech_blog/utils/devise_size.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
    required this.textTheme,
    required this.bodyMargin,
  });

  final TextTheme textTheme;
  final double bodyMargin;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.images.profileAvatar
              .image(height: DeviseSize.getHeight(context) / 6),
          SizedBox(height: DeviseSize.getHeight(context) / 100),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Assets.icons.bluePen.image(height: 20),
              const SizedBox(width: 8),
              Text(
                MySctrings.imageProfileEdit,
                style: textTheme.displaySmall,
              ),
            ],
          ),
          SizedBox(height: DeviseSize.getHeight(context) / 15),
          Text(
            'چنگیز اسدی',
            style: textTheme.headlineMedium,
          ),
          SizedBox(height: DeviseSize.getHeight(context) / 100),
          Text(
            'changiz@gmail.com',
            style: textTheme.headlineMedium,
          ),
          SizedBox(height: DeviseSize.getHeight(context) / 20),
          const TechDivider(),
          SizedBox(height: DeviseSize.getHeight(context) / 50),
          InkWell(
            onTap: () {},
            splashColor: SolidColors.primaryColor,
            child: Text(
              MySctrings.myFavBlog,
              style: textTheme.headlineMedium,
            ),
          ),
          SizedBox(height: DeviseSize.getHeight(context) / 50),
          const TechDivider(),
          SizedBox(height: DeviseSize.getHeight(context) / 50),
          InkWell(
            onTap: () {},
            splashColor: SolidColors.primaryColor,
            child: Text(
              MySctrings.myFavPodcast,
              style: textTheme.headlineMedium,
            ),
          ),
          SizedBox(height: DeviseSize.getHeight(context) / 50),
          const TechDivider(),
          SizedBox(height: DeviseSize.getHeight(context) / 50),
          InkWell(
            onTap: () {},
            splashColor: SolidColors.primaryColor,
            child: Text(
              MySctrings.logOut,
              style: textTheme.headlineMedium,
            ),
          ),
          SizedBox(height: DeviseSize.getHeight(context) / 20),
        ],
      ),
    );
  }
}
