import 'package:get/get.dart';
import 'package:tech_blog/component/api_url.dart';
import 'package:tech_blog/models/article_info_model.dart';
import 'package:tech_blog/models/article_model.dart';
import 'package:tech_blog/models/tag_model.dart';
import 'package:tech_blog/route/names.dart';
import 'package:tech_blog/services/dio_service.dart';

class SingleArticleController extends GetxController {
  RxBool loading = false.obs;
  RxInt id = RxInt(0);
  Rx<ArticleInfoModel> articleInfo = ArticleInfoModel(null, null, null).obs;
  RxList<TagModel> tagList = RxList();
  RxList<ArticleModel> relatedList = RxList();

  getArticleInfo(var id) async {
    loading.value = true;

    var userId = '';

    var response = await DioService().getMethod(
        '${ApiUrl.baseUrl}article/get.php?command=info&id=$id&user_id=$userId');

    if (response.statusCode == 200) {
      articleInfo.value = ArticleInfoModel.fromJson(response.data);
      loading.value = false;
    }
    tagList.clear();
    response.data['tags'].forEach((element) {
      tagList.add(TagModel.fromJson(element));
    });

    relatedList.clear();
    response.data['related'].forEach((element) {
      relatedList.add(ArticleModel.fromJson(element));
    });

    Get.toNamed(NamedRoute.routeSingleArticle);
  }
}
