import 'package:flutter/material.dart';
import 'package:tech_blog/component/my_strings.dart';
import 'package:tech_blog/gen/assets.gen.dart';
import 'package:tech_blog/utils/devise_size.dart';
import 'package:tech_blog/view/my_categories.dart';

class RegisterIntro extends StatelessWidget {
  const RegisterIntro({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Assets.images.tcbot
                  .svg(height: DeviseSize.getHeight(context) / 5),
              Padding(
                padding: const EdgeInsets.only(top: 14),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: MySctrings.welcom,
                    style: textTheme.headlineMedium,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: ElevatedButton(
                  onPressed: () {
                    _showEmailBottomSheet(context, textTheme);
                  },
                  child: const Text(
                    'بزن بریم',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> _showEmailBottomSheet(
      BuildContext context, TextTheme textTheme) {
    return showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      context: context,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SizedBox(
          height: DeviseSize.getHeight(context) / 2.5,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Text(
                    MySctrings.insertYourEmail,
                    style: textTheme.headlineMedium,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 32,
                    left: 24,
                    right: 24,
                  ),
                  child: TextField(
                    style: textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: 'Changiiiiz@gmail.changz',
                      hintStyle: textTheme.headlineSmall,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _showActivateCode(context, textTheme);
                  },
                  child: const Text('ادامه'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> _showActivateCode(BuildContext context, TextTheme textTheme) {
    return showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      context: context,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SizedBox(
          height: DeviseSize.getHeight(context) / 2.5,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Text(
                    MySctrings.activateCode,
                    style: textTheme.headlineMedium,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 32,
                    left: 24,
                    right: 24,
                  ),
                  child: TextField(
                    style: textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: '*******',
                      hintStyle: textTheme.headlineSmall,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) {
                          return const MyCategories();
                        },
                      ),
                    );
                  },
                  child: const Text('ادامه'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
