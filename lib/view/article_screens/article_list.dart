import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_blog/component/cached_image.dart';
import 'package:tech_blog/component/my_app_bar.dart';
import 'package:tech_blog/controller/article/list_article_controller.dart';
import 'package:tech_blog/controller/article/single_article_controller.dart';
import 'package:tech_blog/utils/devise_size.dart';

class ArticleListScreen extends StatelessWidget {
  ArticleListScreen({super.key, this.appBarText});

  final listArticleController = Get.put(ListArticleController());
  final articleInfoController = Get.put(SingleArticleController());
  final String? appBarText;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: myAppBar(textTheme, appBarText ?? 'مقالات جدید'),
      body: Obx(
        () => ListView.builder(
          padding: const EdgeInsets.only(top: 15),
          itemCount: listArticleController.articleList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: InkWell(
                onTap: () {
                  articleInfoController.getArticleInfo(
                      listArticleController.articleList[index].id);
                },
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
                        imageUrl:
                            listArticleController.articleList[index].image,
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
                            listArticleController.articleList[index].title ??
                                '',
                            maxLines: 2,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Row(
                            children: [
                              Text(
                                listArticleController
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
                                listArticleController.articleList[index].view ??
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
        ),
      ),
    );
  }
}
