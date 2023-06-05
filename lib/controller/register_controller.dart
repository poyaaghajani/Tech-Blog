import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tech_blog/component/api_url.dart';
import 'package:tech_blog/component/storage_const.dart';
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
        box.write(token, response.data['token']);
        box.write(userId, response.data['user_id']);

        debugPrint('read::: ${box.read(token)}');
        debugPrint('read::: ${box.read(response.data['user_id'])}');

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
    if (GetStorage().read(token) == null) {
      Get.to(RegisterIntro());
    } else {
      debugPrint('post screen');
    }
  }
}
