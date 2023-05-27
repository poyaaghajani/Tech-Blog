import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tech_blog/component/my_colors.dart';
import 'package:tech_blog/utils/devise_size.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: DeviseSize.getWidth(context),
        height: DeviseSize.getHeight(context),
        child: const SpinKitCubeGrid(
          size: 35,
          color: SolidColors.primaryColor,
        ),
      ),
    );
  }
}
