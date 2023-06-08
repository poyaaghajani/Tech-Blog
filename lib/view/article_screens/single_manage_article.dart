import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:tech_blog/component/loading_widget.dart';
import 'package:tech_blog/component/my_colors.dart';
import 'package:tech_blog/component/see_more_widget.dart';
import 'package:tech_blog/controller/article/manage_article_controller.dart';
import 'package:tech_blog/controller/file_controller.dart';
import 'package:tech_blog/controller/home_screen_controller.dart';
import 'package:tech_blog/gen/assets.gen.dart';
import 'package:tech_blog/services/pick_file.dart';
import 'package:tech_blog/view/article_screens/article_content_editor.dart';

class SingleManageArticle extends StatelessWidget {
  SingleManageArticle({super.key});

  final manageArticleController = Get.find<ManageArticleController>();
  final homeScreenController = Get.find<HomeScreenController>();
  final fileController = Get.put(FileController());

  @override
  Widget build(BuildContext context) {
    var bodyMargin = Get.width / 28;
    var textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Obx(
              () => manageArticleController.loading.value
                  ? const LoadingWidget()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            SizedBox(
                              height: Get.height / 3,
                              width: Get.width,
                              child: fileController.file.value.name == 'any'
                                  ? Assets.images.singlePlaceHolder
                                      .image(fit: BoxFit.cover)
                                  : Image.file(
                                      File(fileController.file.value.path!),
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 65,
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors:
                                        GradientColors.homePosterCoverGradiant,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 8,
                                    right: 8,
                                    bottom: 8,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: (() => Get.back()),
                                        child: const Icon(
                                          Icons.arrow_back,
                                          color: SolidColors.lightIcon,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                await pickFiles();
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: SolidColors.primaryColor,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(12),
                                    topLeft: Radius.circular(12),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'انتخاب تصویر',
                                        style: textTheme.displayMedium,
                                      ),
                                      const Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: Get.height / 30),

                        // see more
                        GestureDetector(
                          onTap: () {
                            changeTitle();
                          },
                          child:
                              const SeeMoreWidget(text: 'ویرایش عنوان مقاله'),
                        ),

                        Padding(
                          padding: EdgeInsets.all(bodyMargin),
                          child: Text(
                            manageArticleController
                                .articleInfoModel.value.title!,
                            style: textTheme.titleLarge,
                          ),
                        ),

                        // see more
                        GestureDetector(
                          onTap: () {
                            Get.to(() => ArticleContentEditor());
                          },
                          child: const SeeMoreWidget(
                              text: 'ویرایش متن اصلی مقاله'),
                        ),

                        Padding(
                          padding: EdgeInsets.all(bodyMargin),
                          child: Html(
                            data: manageArticleController
                                .articleInfoModel.value.content,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            selectTags();
                          },
                          child: const SeeMoreWidget(text: 'انتخاب دسته بندی'),
                        ),

                        Padding(
                          padding: EdgeInsets.all(bodyMargin),
                          child: Text(
                            manageArticleController
                                    .articleInfoModel.value.catName ??
                                'هیچ دسته بندی انتخاب نشده',
                            style: textTheme.headlineSmall,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }

  void changeTitle() {
    Get.defaultDialog(
      title: 'عنوان مقاله',
      titleStyle: const TextStyle(
        color: SolidColors.scaffoldBg,
      ),
      content: TextField(
        controller: manageArticleController.titleController,
        keyboardType: TextInputType.text,
        style: const TextStyle(color: SolidColors.colorTitle),
        decoration: const InputDecoration(
          hintText: 'اینجا بنویس',
          filled: true,
          fillColor: SolidColors.scaffoldBg,
        ),
      ),
      backgroundColor: SolidColors.primaryColor,
      radius: 8,
      confirm: ElevatedButton(
        onPressed: () {
          manageArticleController.updateTitle();
          Get.back();
        },
        child: const Text('ثبت'),
      ),
    );
  }

  void selectTags() {
    Get.bottomSheet(
      Container(
        height: Get.height / 2.5,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Text('انتخاب دسته بندی'),
              const SizedBox(height: 20),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 8,
                runSpacing: 8,
                direction: Axis.horizontal,
                children: [
                  ...List.generate(
                    homeScreenController.tagsList.length,
                    (index) => GestureDetector(
                      onTap: () {
                        manageArticleController.articleInfoModel.update((val) {
                          val!.catId = homeScreenController.tagsList[index].id;
                        });

                        manageArticleController.articleInfoModel.update((val) {
                          val!.catName =
                              homeScreenController.tagsList[index].title;
                        });

                        Get.back();
                      },
                      child: Container(
                        width: Get.width / 3.4,
                        height: Get.height / 12,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: SolidColors.primaryColor,
                        ),
                        child: Center(
                          child: Text(
                            homeScreenController.tagsList[index].title,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
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
