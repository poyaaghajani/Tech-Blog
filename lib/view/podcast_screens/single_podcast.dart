import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:tech_blog/component/cached_image.dart';
import 'package:tech_blog/component/my_colors.dart';
import 'package:tech_blog/controller/podcast/single_podcast_controller.dart';
import 'package:tech_blog/gen/assets.gen.dart';
import 'package:tech_blog/models/podcast_model.dart';
import 'package:tech_blog/utils/default_physics.dart';

class SinglePodcast extends StatelessWidget {
  late SinglePodcastController singlePodcastController;
  late PodcastModel podcastModel;

  SinglePodcast() {
    podcastModel = Get.arguments;
    singlePodcastController = Get.put(
      SinglePodcastController(id: podcastModel.id),
    );
  }
  @override
  Widget build(BuildContext context) {
    print(singlePodcastController.id);
    var textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: Get.height / 3,
                      width: Get.width,
                      child: CachedImage(
                        imageUrl: podcastModel.poster,
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
                            colors: GradientColors.homePosterCoverGradiant,
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
                                onTap: () async {},
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Text(
                    podcastModel.title,
                    maxLines: 2,
                    style: textTheme.titleLarge,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 12, bottom: 20),
                  child: Row(
                    children: [
                      Assets.images.profileAvatar.image(height: 50),
                      const SizedBox(width: 8),
                      Text(
                        podcastModel.author,
                        style: textTheme.headlineMedium,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Obx(
                    () => ListView.builder(
                      physics: defaultPhysics,
                      padding: EdgeInsets.only(
                        right: 16,
                        left: 16,
                        bottom: Get.height / 11,
                      ),
                      itemCount: singlePodcastController.podcastFileList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: Row(
                            children: [
                              Assets.icons.microphon.image(height: 20),
                              const SizedBox(width: 8),
                              SizedBox(
                                width: Get.width / 1.7,
                                child: Text(
                                  singlePodcastController
                                          .podcastFileList[index].title ??
                                      '',
                                  style: textTheme.headlineMedium,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                '00 : ${singlePodcastController.podcastFileList[index].length!}',
                                style: textTheme.headlineMedium,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 8,
              child: Container(
                width: Get.width / 1.25,
                height: Get.height / 9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  gradient: const LinearGradient(
                    colors: GradientColors.bottomNav,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      LinearPercentIndicator(
                        percent: 0.4,
                        backgroundColor: Colors.white,
                        progressColor: Colors.orange,
                        lineHeight: 7,
                        barRadius: const Radius.circular(10),
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(
                            Icons.skip_next,
                            color: Colors.white,
                            size: 35,
                          ),
                          Icon(
                            Icons.play_circle_fill,
                            color: Colors.white,
                            size: 48,
                          ),
                          Icon(
                            Icons.skip_previous,
                            color: Colors.white,
                            size: 35,
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Icon(
                            Icons.repeat,
                            color: Colors.blue,
                            size: 30,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
