import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tech_blog/component/my_colors.dart';
import 'package:tech_blog/my_http_overrides.dart';
import 'package:tech_blog/themes/app_theme.dart';
import 'package:tech_blog/view/article_screens/manage_article.dart';
import 'package:tech_blog/view/article_screens/single_article.dart';
import 'package:tech_blog/view/article_screens/single_manage_article.dart';
import 'package:tech_blog/view/binding.dart';
import 'package:tech_blog/view/main_screens/main_screen.dart';
import 'package:tech_blog/view/podcast_screens/single_podcast.dart';
import 'package:tech_blog/view/splash_screen.dart';

void main() async {
  HttpOverrides.global = MyHttpOverrides();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: SolidColors.statusBarColor,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: SolidColors.systemNavigationBarColor,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      locale: const Locale('fa'),
      theme: AppTheme.lightTheme,
      getPages: [
        GetPage(
          name: NamedRoute.routeMainScreen,
          page: () => MainScreen(),
          binding: RegisterBinding(),
        ),
        GetPage(
          name: NamedRoute.routeSingleArticle,
          page: () => SingleArticleScreen(),
          binding: ArticleBinding(),
        ),
        GetPage(
          name: NamedRoute.manageArticle,
          page: () => const ManageArticle(),
          binding: ArticleManagerBinding(),
        ),
        GetPage(
          name: NamedRoute.manageArticle,
          page: () => const ManageArticle(),
          binding: ArticleManagerBinding(),
        ),
        GetPage(
          name: NamedRoute.singleManageArticle,
          page: () => SingleManageArticle(),
          binding: ArticleManagerBinding(),
        ),
        GetPage(
          name: NamedRoute.singlePodcast,
          page: () => SinglePodcast(),
        ),
      ],
    );
  }
}

class NamedRoute {
  NamedRoute._();

  static String routeMainScreen = '/main_screen';
  static String routeSingleArticle = '/single_article';
  static String manageArticle = '/manage_article';
  static String singleManageArticle = '/single_manage_article';
  static String singlePodcast = '/single_podcast';
}
