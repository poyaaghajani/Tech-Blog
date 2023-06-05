import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:tech_blog/component/my_colors.dart';
import 'package:tech_blog/gen/assets.gen.dart';
import 'package:tech_blog/main.dart';
import 'package:tech_blog/utils/devise_size.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    nextScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          const SizedBox(
            width: double.infinity,
            height: double.infinity,
          ),
          Assets.images.logo.image(height: DeviseSize.getHeight(context) / 8),
          const Positioned(
            bottom: 45,
            child: SpinKitCubeGrid(
              size: 35,
              color: SolidColors.primaryColor,
            ),
          )
        ],
      ),
    );
  }

  Future<void> nextScreen() async {
    await Future.delayed(
      const Duration(seconds: 4),
    );

    Get.offAndToNamed(routeMainScreen);
  }
}
