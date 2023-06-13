import 'package:get/get.dart';
import 'package:tech_blog/component/api_url.dart';
import 'package:tech_blog/models/podcast_file_model.dart';
import 'package:tech_blog/services/dio_service.dart';

class SinglePodcastController extends GetxController {
  var id;

  SinglePodcastController({this.id});

  RxBool loading = false.obs;
  RxList<PodcastFileModel> podcastFileList = RxList();

  @override
  onInit() {
    getPodcastFiles();
    super.onInit();
  }

  getPodcastFiles() async {
    loading.value = true;

    var response = await DioService().getMethod(ApiUrl.podcastFiles + id);

    if (response.statusCode == 200) {
      for (var element in response.data['files']) {
        podcastFileList.add(PodcastFileModel.fromJson(element));
      }
      loading.value = false;
    }
  }
}
