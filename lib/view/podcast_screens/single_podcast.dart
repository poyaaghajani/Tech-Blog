import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_blog/component/cached_image.dart';
import 'package:tech_blog/component/my_colors.dart';
import 'package:tech_blog/controller/podcast/single_podcast_controller.dart';
import 'package:tech_blog/gen/assets.gen.dart';
import 'package:tech_blog/models/podcast_model.dart';
import 'package:tech_blog/utils/default_physics.dart';

class SinglePodcast extends StatelessWidget {
  late SinglePodcastController controller;
  late PodcastModel podcastModel;

  SinglePodcast({super.key}) {
    podcastModel = Get.arguments;
    controller = Get.put(
      SinglePodcastController(id: podcastModel.id),
    );
  }
  @override
  Widget build(BuildContext context) {
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
                        fit: BoxFit.fill,
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
                      itemCount: controller.podcastFileList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () async {
                            await controller.player
                                .seek(Duration.zero, index: index);
                            controller.currentFileIndex.value =
                                controller.player.currentIndex!;
                            controller.timerCheck();
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 30),
                            child: Row(
                              children: [
                                Assets.icons.microphon.image(height: 20),
                                const SizedBox(width: 8),
                                SizedBox(
                                  width: Get.width / 1.7,
                                  child: Obx(
                                    () => Text(
                                      controller.podcastFileList[index].title ??
                                          '',
                                      style:
                                          controller.currentFileIndex.value ==
                                                  index
                                              ? textTheme.headlineMedium!
                                                  .apply(color: Colors.orange)
                                              : textTheme.headlineMedium,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  '00 : ${controller.podcastFileList[index].length!}',
                                  style: textTheme.headlineMedium,
                                ),
                              ],
                            ),
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
                height: Get.height / 8,
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
                      Obx(
                        () => SizedBox(
                          height: 30,
                          child: ProgressBar(
                            baseBarColor: Colors.white,
                            thumbColor: Colors.orange,
                            progressBarColor: Colors.orange,
                            onSeek: (position) async {
                              controller.player.seek(position);

                              if (controller.player.playing) {
                                controller.startProgress();
                              } else if (position <=
                                  const Duration(seconds: 0)) {
                                await controller.player.seekToNext();
                                controller.currentFileIndex.value =
                                    controller.player.currentIndex!;
                                controller.timerCheck();
                              }
                            },
                            timeLabelTextStyle: const TextStyle(
                                color: Colors.white, fontSize: 13),
                            buffered: controller.bufferdValue.value,
                            progress: controller.progressValue.value,
                            total: controller.player.duration ??
                                const Duration(seconds: 0),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              await controller.player.seekToNext();
                              controller.currentFileIndex.value =
                                  controller.player.currentIndex!;
                              controller.timerCheck();
                            },
                            child: const Icon(
                              Icons.skip_next,
                              color: Colors.white,
                              size: 35,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.player.playing
                                  ? controller.timer!.cancel()
                                  : controller.startProgress();

                              controller.player.playing
                                  ? controller.player.pause()
                                  : controller.player.play();

                              controller.playState.value =
                                  controller.player.playing;

                              controller.currentFileIndex.value =
                                  controller.player.currentIndex!;
                            },
                            child: Obx(
                              () => Icon(
                                controller.playState.value
                                    ? Icons.pause_circle_filled
                                    : Icons.play_circle_fill,
                                color: Colors.white,
                                size: 48,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              await controller.player.seekToPrevious();
                              controller.currentFileIndex.value =
                                  controller.player.currentIndex!;
                              controller.timerCheck();
                            },
                            child: const Icon(
                              Icons.skip_previous,
                              color: Colors.white,
                              size: 35,
                            ),
                          ),
                          const SizedBox(width: 30),
                          Obx(
                            () => GestureDetector(
                              onTap: () {
                                controller.setLoopMode();
                              },
                              child: Icon(
                                Icons.repeat,
                                color: controller.loopOn.value
                                    ? Colors.blue
                                    : Colors.white,
                                size: 30,
                              ),
                            ),
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
