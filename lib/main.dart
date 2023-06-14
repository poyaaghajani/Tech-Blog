import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tech_blog/component/my_colors.dart';
import 'package:tech_blog/my_http_overrides.dart';
import 'package:tech_blog/route/names.dart';
import 'package:tech_blog/route/pages.dart';
import 'package:tech_blog/themes/app_theme.dart';

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
      initialRoute: NamedRoute.routeInitial,
      locale: const Locale('fa'),
      theme: AppTheme.lightTheme,
      getPages: Pages.pages,
    );
  }
}
