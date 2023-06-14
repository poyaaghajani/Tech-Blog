import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tech_blog/component/api_url.dart';
import 'package:tech_blog/component/my_colors.dart';
import 'package:tech_blog/component/storage_const.dart';
import 'package:tech_blog/gen/assets.gen.dart';
import 'package:tech_blog/route/names.dart';
import 'package:tech_blog/services/dio_service.dart';
import 'package:tech_blog/view/main_screens/main_screen.dart';
import 'package:tech_blog/view/register_screens/register_intro.dart';

class RegisterController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController activeCodeController = TextEditingController();

  var email = '';
  var userId = '';

  register() async {
    Map<String, dynamic> map = {
      'email': emailController.text,
      'command': 'register',
    };

    var response = await DioService().postMethod(map, ApiUrl.postRegister);

    email = emailController.text;
    userId = response.data['user_id'];
  }

  verify() async {
    Map<String, dynamic> map = {
      'email': email,
      'user_id': userId,
      'code': activeCodeController.text,
      'command': 'verify',
    };

    var response = await DioService().postMethod(map, ApiUrl.postRegister);

    var status = response.data['response'];

    switch (status) {
      case 'verified':
        var box = GetStorage();
        box.write(StorageConst.token, response.data['token']);
        box.write(StorageConst.userId, response.data['user_id']);

        debugPrint('read::: ${box.read(StorageConst.token)}');
        debugPrint('read::: ${box.read(StorageConst.userId)}');

        Get.offAll(MainScreen());

        break;

      case 'incorrect_code':
        Get.snackbar('خطا', 'کد فعالسازی اشتباه است');
        break;

      case 'expired':
        Get.snackbar('خطا', 'کد فعالسازی منقضی شده است');
        break;
    }
  }

  toggleLogin() {
    if (GetStorage().read(StorageConst.token) == null) {
      Get.to(RegisterIntro());
    } else {
      routeToArticleBottomSheet();
    }
  }

  routeToArticleBottomSheet() {
    Get.bottomSheet(
      Container(
        height: Get.height / 3,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Assets.images.tcbot.svg(height: 40),
                  const SizedBox(width: 8),
                  const Text(
                    'دونسته هات رو با بقیه به اشتراک بزار',
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const Text(
                'فکر کن!! اینجا بودنت به این معناست که یک گیگ تکنولوژی هستی\nدونسته هات رو با جامعه ی گیگ های فارسی به اشتراک بزار',
                style: TextStyle(
                    fontFamily: 'dana',
                    fontSize: 13,
                    color: SolidColors.hintText,
                    fontWeight: FontWeight.w700),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(NamedRoute.manageArticle);
                    },
                    child: SizedBox(
                      height: 65,
                      child: Row(
                        children: [
                          Assets.icons.writeArticle.image(height: 40),
                          const SizedBox(width: 8),
                          const Text('مدیریت مقاله ها'),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: SizedBox(
                      height: 65,
                      child: Row(
                        children: [
                          Assets.icons.writePodcastIcon.image(height: 40),
                          const SizedBox(width: 8),
                          const Text('مدیریت پادکست ها'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
