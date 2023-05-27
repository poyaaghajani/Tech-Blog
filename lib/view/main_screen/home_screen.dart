// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_blog/component/cached_image.dart';
import 'package:tech_blog/component/loading_widget.dart';
import 'package:tech_blog/component/my_colors.dart';
import 'package:tech_blog/component/my_strings.dart';
import 'package:tech_blog/controller/home_screen_controller.dart';
import 'package:tech_blog/gen/assets.gen.dart';
import 'package:tech_blog/models/data_models.dart';
import 'package:tech_blog/utils/default_physics.dart';
import 'package:tech_blog/utils/devise_size.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({
    super.key,
    required this.textTheme,
    required this.bodyMargin,
  });

  final TextTheme textTheme;
  final double bodyMargin;
  final homeScreenController = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    homeScreenController.getHomeItems();
    return Obx(
      () => SingleChildScrollView(
        physics: defaultPhysics,
        child: homeScreenController.loading == false
            ? Column(
                children: [
                  SizedBox(height: DeviseSize.getHeight(context) / 90),

                  // home poster
                  homePoster(context),

                  SizedBox(height: DeviseSize.getHeight(context) / 40),

                  // hashtags
                  hashTags(context),

                  SizedBox(height: DeviseSize.getHeight(context) / 12),

                  Padding(
                    padding: EdgeInsets.only(right: bodyMargin),
                    child: Row(
                      children: [
                        Assets.icons.bluePen.image(height: 20),
                        const SizedBox(width: 8),
                        Text(
                          MySctrings.viewHotestBlog,
                          style: textTheme.displaySmall,
                        ),
                      ],
                    ),
                  ),

                  // hotest blogs
                  hotestBlogs(context),

                  SizedBox(height: DeviseSize.getHeight(context) / 16),

                  Padding(
                    padding: EdgeInsets.only(right: bodyMargin),
                    child: Row(
                      children: [
                        Assets.icons.microphon.image(height: 20),
                        const SizedBox(width: 8),
                        Text(
                          MySctrings.viewHotestPodCasts,
                          style: textTheme.displaySmall,
                        ),
                      ],
                    ),
                  ),

                  // hotest podcast
                  hotestPodcasts(context),
                ],
              )
            : const LoadingWidget(),
      ),
    );
  }

  // hotest blogs
  Widget hotestBlogs(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      height: DeviseSize.getHeight(context) / 3.9,
      child: Obx(
        () => ListView.builder(
          physics: defaultPhysics,
          padding: EdgeInsets.only(right: bodyMargin),
          itemCount: homeScreenController.topVisitedList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Column(
              children: [
                SizedBox(
                  width: DeviseSize.getWidth(context) / 2.4,
                  height: DeviseSize.getHeight(context) / 5.3,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        height: DeviseSize.getHeight(context) / 5.3,
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
                              homeScreenController.topVisitedList[index].image,
                          radius: 16,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              homeScreenController.topVisitedList[index].author,
                              style: textTheme.titleMedium,
                            ),
                            Row(
                              children: [
                                Text(
                                  homeScreenController
                                      .topVisitedList[index].view,
                                  style: textTheme.titleMedium,
                                ),
                                SizedBox(
                                    width: DeviseSize.getWidth(context) / 100),
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
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: SizedBox(
                    width: DeviseSize.getWidth(context) / 2.4,
                    child: Text(
                      homeScreenController.topVisitedList[index].title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // hotest podcasts
  Widget hotestPodcasts(BuildContext context) {
    return Obx(
      () => Container(
        margin: EdgeInsets.only(
          top: 15,
          bottom: DeviseSize.getHeight(context) / 12,
        ),
        height: DeviseSize.getHeight(context) / 4,
        child: ListView.builder(
          physics: defaultPhysics,
          padding: EdgeInsets.only(right: bodyMargin),
          itemCount: homeScreenController.topPodcastList.length ~/ 2,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Column(
              children: [
                SizedBox(
                  width: DeviseSize.getWidth(context) / 2.4,
                  height: DeviseSize.getHeight(context) / 5.3,
                  child: homeScreenController.topPodcastList[index].poster ==
                          "https://techblog.sasansafari.com''"
                      ? const Icon(
                          Icons.image_not_supported_outlined,
                          size: 40,
                          color: SolidColors.primaryColor,
                        )
                      : CachedImage(
                          imageUrl:
                              homeScreenController.topPodcastList[index].poster,
                          radius: 16,
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 4),
                  child: SizedBox(
                    width: DeviseSize.getWidth(context) / 2.4,
                    child: Text(
                      homeScreenController.topPodcastList[index].author,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget homePoster(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          width: DeviseSize.getWidth(context) / 1.25,
          height: DeviseSize.getHeight(context) / 4.2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          foregroundDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: GradientColors.homePosterCoverGradiant,
            ),
          ),
          child: CachedImage(
            imageUrl: homeScreenController.poster.value.image,
            radius: 16,
          ),
        ),
        Positioned(
          bottom: 5,
          right: 5,
          child: SizedBox(
            width: DeviseSize.getWidth(context) / 1.2,
            height: 50,
            child: Text(
              homeScreenController.poster.value.title!,
              style: textTheme.displayLarge,
            ),
          ),
        ),
      ],
    );
  }

  Widget hashTags(BuildContext context) {
    return SizedBox(
      height: 35,
      child: ListView.builder(
        physics: defaultPhysics,
        padding: EdgeInsets.only(right: bodyMargin),
        itemCount: tagList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            margin: const EdgeInsets.only(left: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: const LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                colors: GradientColors.tags,
              ),
            ),
            child: Center(
              child: Row(
                children: [
                  Assets.icons.hashtagicon.image(height: 18),
                  SizedBox(width: DeviseSize.getWidth(context) / 60),
                  Text(
                    homeScreenController.tagsList[index].title,
                    style: textTheme.displayLarge,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
