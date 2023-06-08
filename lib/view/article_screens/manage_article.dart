import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_blog/component/cached_image.dart';
import 'package:tech_blog/component/loading_widget.dart';
import 'package:tech_blog/component/my_app_bar.dart';
import 'package:tech_blog/component/my_colors.dart';
import 'package:tech_blog/component/my_strings.dart';
import 'package:tech_blog/controller/article/manage_article_controller.dart';
import 'package:tech_blog/gen/assets.gen.dart';
import 'package:tech_blog/main.dart';
import 'package:tech_blog/utils/devise_size.dart';

class ManageArticle extends StatelessWidget {
  const ManageArticle({super.key});

  @override
  Widget build(BuildContext context) {
    var articleManageController = Get.find<ManageArticleController>();
    var textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Scaffold(
        appBar: myAppBar(textTheme, 'مدیریت مقاله'),
        body: Obx(() => articleManageController.loading.isTrue
            ? const LoadingWidget()
            : articleManageController.articleList.isNotEmpty
                ? ListView.builder(
                    padding: const EdgeInsets.only(top: 15),
                    itemCount: articleManageController.articleList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: InkWell(
                          onTap: () {},
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 20),
                                width: DeviseSize.getWidth(context) / 3,
                                height: DeviseSize.getHeight(context) / 6.5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: CachedImage(
                                  radius: 24,
                                  imageUrl: articleManageController
                                      .articleList[index].image,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: DeviseSize.getWidth(context) / 2,
                                    child: Text(
                                      articleManageController
                                              .articleList[index].title ??
                                          '',
                                      maxLines: 2,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 6),
                                    child: Row(
                                      children: [
                                        Text(
                                          articleManageController
                                                  .articleList[index].author ??
                                              '',
                                          style: textTheme.bodySmall,
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          'بازدید: ',
                                          style: textTheme.bodySmall,
                                        ),
                                        Text(
                                          articleManageController
                                                  .articleList[index].view ??
                                              '200',
                                          style: textTheme.bodySmall,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : articleEmptyState(context, textTheme)),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: SolidColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          onPressed: () {
            Get.toNamed(NamedRoute.singleManageArticle);
          },
          label: Text(
            'بریم برای نوشتن یه مقاله باحال',
            style: textTheme.displayLarge,
          ),
        ),
      ),
    );
  }

  Widget articleEmptyState(BuildContext context, TextTheme textTheme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.images.emptyState
              .image(height: DeviseSize.getHeight(context) / 5),
          Padding(
            padding: const EdgeInsets.only(top: 14),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: MySctrings.articleEmpty,
                style: textTheme.headlineMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
