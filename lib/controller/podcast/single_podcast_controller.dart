import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:tech_blog/component/api_url.dart';
import 'package:tech_blog/models/podcast_file_model.dart';
import 'package:tech_blog/services/dio_service.dart';

class SinglePodcastController extends GetxController {
  var id;

  SinglePodcastController({this.id});

  RxBool loading = false.obs;
  RxList<PodcastFileModel> podcastFileList = RxList();
  final player = AudioPlayer();
  late var playList;
  RxBool playState = false.obs;
  RxInt currentFileIndex = 0.obs;
  RxBool loopOn = false.obs;

  @override
  onInit() async {
    playList = ConcatenatingAudioSource(useLazyPreparation: true, children: []);

    await getPodcastFiles();
    await player.setAudioSource(
      playList,
      initialIndex: 0,
      initialPosition: Duration.zero,
    );

    super.onInit();
  }

  getPodcastFiles() async {
    loading.value = true;

    var response = await DioService().getMethod(ApiUrl.podcastFiles + id);

    if (response.statusCode == 200) {
      for (var element in response.data['files']) {
        podcastFileList.add(PodcastFileModel.fromJson(element));
        playList.add(
          AudioSource.uri(Uri.parse(PodcastFileModel.fromJson(element).file!)),
        );
      }
      loading.value = false;
    }
  }

  Rx<Duration> progressValue = const Duration(seconds: 0).obs;
  Rx<Duration> bufferdValue = const Duration(seconds: 0).obs;
  Timer? timer;

  startProgress() {
    var tick = const Duration(seconds: 1);
    var duration = player.duration!.inSeconds - player.position.inSeconds;

    if (timer != null && timer!.isActive) {
      timer!.cancel();
      timer = null;
    }

    timer = Timer.periodic(tick, (timer) {
      duration--;
      debugPrint('$duration => ${player.currentIndex}');
      progressValue.value = player.position;
      bufferdValue.value = player.bufferedPosition;

      if (duration <= 0) {
        timer.cancel();
        progressValue.value = const Duration(seconds: 0);
        bufferdValue.value = const Duration(seconds: 0);
      }
    });
  }

  timerCheck() {
    if (player.playing) {
      startProgress();
    } else {
      timer!.cancel();
      progressValue.value = const Duration(seconds: 0);
      bufferdValue.value = const Duration(seconds: 0);
    }
  }

  setLoopMode() {
    if (loopOn.value) {
      loopOn.value = false;
      player.setLoopMode(LoopMode.off);
    } else {
      loopOn.value = true;
      player.setLoopMode(LoopMode.all);
    }
  }
}
