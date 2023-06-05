import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tech_blog/component/lunch_url.dart';
import 'package:tech_blog/component/my_colors.dart';
import 'package:tech_blog/component/my_strings.dart';
import 'package:tech_blog/controller/register_controller.dart';
import 'package:tech_blog/gen/assets.gen.dart';
import 'package:tech_blog/utils/devise_size.dart';
import 'package:tech_blog/view/main_screens/home_screen.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final RxInt selektedScreenIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> key = GlobalKey();

    var bodyMargin = DeviseSize.getWidth(context) / 28;
    var textTheme = Theme.of(context).textTheme;

    return Scaffold(
      key: key,
      drawer: TechDrawer(bodyMargin: bodyMargin, textTheme: textTheme),
      appBar: AppBar(
        backgroundColor: SolidColors.scaffoldBg,
        elevation: 0,
        leading: IconButton(
          padding: const EdgeInsets.only(right: 12),
          onPressed: () {
            key.currentState!.openDrawer();
          },
          icon: const Icon(
            Icons.menu,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        title: Assets.images.logo.image(height: Get.width / 13.6),
        actions: [
          IconButton(
            padding: const EdgeInsets.only(left: 12),
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Obx(
              () => IndexedStack(
                index: selektedScreenIndex.value,
                children: [
                  HomeScreen(textTheme: textTheme, bodyMargin: bodyMargin),
                ],
              ),
            ),
          ),
          BottomNav(
            bodyMargin: bodyMargin,
            changeScreen: (int value) {
              selektedScreenIndex.value = value;
            },
          ),
        ],
      ),
    );
  }
}

class TechDrawer extends StatelessWidget {
  const TechDrawer({
    super.key,
    required this.bodyMargin,
    required this.textTheme,
  });

  final double bodyMargin;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: SolidColors.surface,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: bodyMargin),
        children: [
          DrawerHeader(
            child: Assets.images.logo.image(scale: 3),
          ),
          const Divider(
            color: SolidColors.dividerColor,
          ),
          ListTile(
            title: Text(
              'پروفایل کاربری',
              style: textTheme.headlineMedium,
            ),
          ),
          const Divider(
            color: SolidColors.dividerColor,
          ),
          ListTile(
            title: Text(
              'درباره تک بلاگ',
              style: textTheme.headlineMedium,
            ),
          ),
          const Divider(
            color: SolidColors.dividerColor,
          ),
          ListTile(
            title: Text(
              'اشتراک گذاری تک بلاگ',
              style: textTheme.headlineMedium,
            ),
            onTap: () async {
              await Share.share(MySctrings.shareText);
            },
          ),
          const Divider(
            color: SolidColors.dividerColor,
          ),
          ListTile(
              title: Text(
                'تک بلاگ در گیت هاب',
                style: textTheme.headlineMedium,
              ),
              onTap: () {
                mylaunchUrl(MySctrings.techBlogGitHubUrl);
              }),
        ],
      ),
    );
  }
}

class BottomNav extends StatelessWidget {
  const BottomNav({
    super.key,
    required this.bodyMargin,
    required this.changeScreen,
  });

  final double bodyMargin;
  final Function(int) changeScreen;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 6,
      right: 0,
      left: 0,
      child: Container(
        height: DeviseSize.getHeight(context) / 11,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: GradientColors.bottomNavBackground,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: bodyMargin + 14),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              gradient: const LinearGradient(
                colors: GradientColors.bottomNav,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    changeScreen(0);
                  },
                  icon: Assets.icons.home.image(),
                ),
                IconButton(
                  onPressed: () {
                    Get.find<RegisterController>().toggleLogin();
                  },
                  icon: Assets.icons.write.image(),
                ),
                IconButton(
                  onPressed: () {
                    changeScreen(2);
                  },
                  icon: Assets.icons.user.image(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
