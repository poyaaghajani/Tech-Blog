import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tech_blog/component/cached_image.dart';
import 'package:tech_blog/component/loading_widget.dart';
import 'package:tech_blog/component/my_colors.dart';
import 'package:tech_blog/controller/list_article_controller.dart';
import 'package:tech_blog/controller/single_article_controller.dart';
import 'package:tech_blog/gen/assets.gen.dart';
import 'package:tech_blog/utils/default_physics.dart';
import 'package:tech_blog/view/article_screens/article_list.dart';

class SingleArticleScreen extends StatelessWidget {
  SingleArticleScreen({super.key});

  final singleArticleController = Get.find<SingleArticleController>();
  final articleListController = Get.put(ListArticleController());

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Obx(
            () => singleArticleController.articleInfo.value.title == null
                ? SizedBox(height: Get.height, child: const LoadingWidget())
                : singleArticleController.loading.value
                    ? const LoadingWidget()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              SizedBox(
                                height: Get.height / 3,
                                width: Get.width,
                                child: CachedImage(
                                  imageUrl: singleArticleController
                                      .articleInfo.value.image,
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
                                      colors: GradientColors
                                          .homePosterCoverGradiant,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 8,
                                      right: 8,
                                      bottom: 8,
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                          onTap: (() => Get.back()),
                                          child: const Icon(
                                            Icons.arrow_back,
                                            color: SolidColors.lightIcon,
                                          ),
                                        ),
                                        const Expanded(child: SizedBox()),
                                        const Icon(
                                          Icons.bookmark_border_rounded,
                                          color: SolidColors.lightIcon,
                                        ),
                                        const SizedBox(width: 14),
                                        GestureDetector(
                                          onTap: () async {
                                            await Share.share(
                                                singleArticleController
                                                    .articleInfo.value.title!);
                                          },
                                          child: const Icon(
                                            Icons.share,
                                            color: SolidColors.lightIcon,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            child: Text(
                              singleArticleController.articleInfo.value.title!,
                              maxLines: 2,
                              style: textTheme.titleLarge,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            child: Row(
                              children: [
                                Assets.images.profileAvatar.image(height: 50),
                                const SizedBox(width: 8),
                                Text(
                                  singleArticleController
                                      .articleInfo.value.author!,
                                  style: textTheme.headlineMedium,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  singleArticleController
                                      .articleInfo.value.createdAt!,
                                  style: textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 8, right: 8, top: 8, bottom: 45),
                            child: Html(
                              data: singleArticleController
                                  .articleInfo.value.content,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: 30, right: 8),
                            child: Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              direction: Axis.horizontal,
                              children: [
                                ...List.generate(
                                  singleArticleController.tagList.length,
                                  (index) => GestureDetector(
                                    onTap: () async {
                                      var tagId = singleArticleController
                                          .tagList[index].id;
                                      var appBarText = singleArticleController
                                          .tagList[index].title;
                                      articleListController
                                          .getArticleListWithTagsId(tagId);
                                      Get.to(ArticleListScreen(
                                        appBarText: appBarText,
                                      ));
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 2),
                                      width: Get.width / 3.4,
                                      height: Get.height / 20,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(24),
                                        color: SolidColors.submitArticle,
                                      ),
                                      child: Center(
                                        child: Text(singleArticleController
                                            .tagList[index].title),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          RelatedArticles(
                            singleArticleController: singleArticleController,
                            textTheme: textTheme,
                          )
                        ],
                      ),
          ),
        ),
      ),
    );
  }
}

class RelatedArticles extends StatelessWidget {
  const RelatedArticles({
    super.key,
    required this.singleArticleController,
    required this.textTheme,
  });

  final SingleArticleController singleArticleController;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height / 4,
      child: ListView.builder(
        physics: defaultPhysics,
        padding: const EdgeInsets.only(right: 8),
        scrollDirection: Axis.horizontal,
        itemCount: singleArticleController.relatedList.length,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  singleArticleController.getArticleInfo(
                      singleArticleController.relatedList[index].id);
                },
                child: SizedBox(
                  width: Get.width / 2.2,
                  height: Get.height / 5.3,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        height: Get.height / 5.3,
                        margin: const EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        foregroundDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: const LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: GradientColors.blogPost,
                          ),
                        ),
                        child: CachedImage(
                          imageUrl:
                              singleArticleController.relatedList[index].image,
                          radius: 16,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              singleArticleController.relatedList[index].author,
                              style: textTheme.titleMedium,
                            ),
                            Row(
                              children: [
                                Text(
                                  singleArticleController
                                      .relatedList[index].view,
                                  style: textTheme.titleMedium,
                                ),
                                const SizedBox(width: 6),
                                const Icon(
                                  Icons.remove_red_eye_sharp,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: SizedBox(
                  width: Get.width / 2.5,
                  child: Text(
                    singleArticleController.relatedList[index].title,
                    maxLines: 2,
                    style: textTheme.bodyMedium,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
