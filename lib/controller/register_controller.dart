import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tech_blog/component/api_url.dart';
import 'package:tech_blog/component/storage_const.dart';
import 'package:tech_blog/services/dio_service.dart';
import 'package:tech_blog/view/main_screens/main_screen.dart';

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

    if (response.data['response'] == 'verified') {
      var box = GetStorage();
      box.write(token, response.data['token']);
      box.write(userId, response.data['user_id']);

      debugPrint('read::: ${box.read(token)}');
      debugPrint('read::: ${box.read(response.data['user_id'])}');

      Get.to(MainScreen());
    } else {
      debugPrint('error');
    }
  }
}
