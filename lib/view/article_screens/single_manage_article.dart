import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:tech_blog/component/loading_widget.dart';
import 'package:tech_blog/component/my_colors.dart';
import 'package:tech_blog/component/see_more_widget.dart';
import 'package:tech_blog/controller/article/manage_article_controller.dart';
import 'package:tech_blog/gen/assets.gen.dart';

class SingleManageArticle extends StatelessWidget {
  SingleManageArticle({super.key});

  final manageArticleController = Get.find<ManageArticleController>();

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
                              child: Assets.images.singlePlaceHolder
                                  .image(fit: BoxFit.fill),
                            ),
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 60,
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
                              onTap: () {},
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
                        const SeeMoreWidget(text: 'ویرایش عنوان مقاله'),

                        Padding(
                          padding: EdgeInsets.all(bodyMargin),
                          child: Text(
                            manageArticleController
                                .articleInfoModel.value.title!,
                            maxLines: 2,
                            style: textTheme.titleLarge,
                          ),
                        ),

                        // see more
                        const SeeMoreWidget(text: 'ویرایش متن اصلی مقاله'),

                        Padding(
                          padding: EdgeInsets.all(bodyMargin),
                          child: Html(
                            data: manageArticleController
                                .articleInfoModel.value.content,
                          ),
                        ),
                        const SeeMoreWidget(text: 'انتخاب دسته بندی'),

                        // Padding(
                        //   padding: const EdgeInsets.only(bottom: 30, right: 8),
                        //   child: Wrap(
                        //     spacing: 8,
                        //     runSpacing: 8,
                        //     direction: Axis.horizontal,
                        //     children: [
                        //       ...List.generate(
                        //         manageArticleController.tagList.length,
                        //         (index) => GestureDetector(
                        //           onTap: () async {},
                        //           child: Container(
                        //             padding: const EdgeInsets.symmetric(
                        //                 horizontal: 2),
                        //             width: Get.width / 3.4,
                        //             height: Get.height / 20,
                        //             decoration: BoxDecoration(
                        //               borderRadius: BorderRadius.circular(24),
                        //               color: SolidColors.submitArticle,
                        //             ),
                        //             child: Center(
                        //               child: Text(manageArticleController
                        //                   .tagList[index].title),
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
