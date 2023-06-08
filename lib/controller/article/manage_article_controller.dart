import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tech_blog/component/api_url.dart';
import 'package:tech_blog/component/storage_const.dart';
import 'package:tech_blog/controller/file_controller.dart';
import 'package:tech_blog/models/article_info_model.dart';
import 'package:tech_blog/models/article_model.dart';
import 'package:tech_blog/models/tag_model.dart';
import 'package:tech_blog/services/dio_service.dart';

class ManageArticleController extends GetxController {
  RxList<ArticleModel> articleList = RxList.empty();
  TextEditingController titleController = TextEditingController();
  Rx<ArticleInfoModel> articleInfoModel = ArticleInfoModel(
    'اینجا عنوان مقاله قرار میگیره،یه عنوان جذاب انتخاب کن',
    'اینجا محتوای مقاله قرار میگیره',
    '',
  ).obs;
  RxList<TagModel> tagList = RxList.empty();

  RxBool loading = false.obs;
  RxBool articleLoading = false.obs;

  @override
  onInit() {
    super.onInit();
    getManageArticle();
  }

  getManageArticle() async {
    loading.value = true;

    var response = await DioService().getMethod(
      '${ApiUrl.publishedByMe}${GetStorage().read(StorageConst.userId)}',
    );

    if (response.statusCode == 200) {
      response.data.forEach((element) {
        articleList.add(ArticleModel.fromJson(element));
      });

      loading.value = false;
    }
  }

  updateTitle() {
    articleInfoModel.update((val) {
      val!.title = titleController.text;
    });
  }

  storeArticle() async {
    var fileController = Get.find<FileController>();
    articleLoading.value = true;

    Map<String, dynamic> map = {
      'title': articleInfoModel.value.title,
      'content': articleInfoModel.value.content,
      'cat_id': articleInfoModel.value.catId,
      'user_id': GetStorage().read(StorageConst.userId),
      'image':
          await dio.MultipartFile.fromFile(fileController.file.value.path!),
      'command': 'store',
      'tag_list': '[]',
    };

    var response = await DioService().postMethod(map, ApiUrl.articlePost);

    articleLoading.value = false;

    print(response.data);
  }
}
