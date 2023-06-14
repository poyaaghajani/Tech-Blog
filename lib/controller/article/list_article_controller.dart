import 'package:get/get.dart';
import 'package:tech_blog/component/api_url.dart';
import 'package:tech_blog/models/article_model.dart';
import 'package:tech_blog/services/dio_service.dart';

class ListArticleController extends GetxController {
  RxList<ArticleModel> articleList = RxList();

  RxBool loading = false.obs;

  @override
  onInit() {
    super.onInit();
    getArticleList();
  }

  getArticleList() async {
    loading.value = true;

    var response = await DioService().getMethod(ApiUrl.getArticleList);

    if (response.statusCode == 200) {
      response.data.forEach((element) {
        articleList.add(ArticleModel.fromJson(element));
      });

      loading.value = false;
    }
  }

  getArticleListWithTagsId(String id) async {
    articleList.clear();
    loading.value = true;

    final quaryParams = {
      'command': 'get_articles_with_tag_id',
      'tag_id': id,
      'user_id': '',
    };

    final uri = Uri.https(ApiUrl.baseUrl, 'article/get.php?', quaryParams);

    var response = await DioService().getMethod(uri.toString());

    if (response.statusCode == 200) {
      response.data.forEach((element) {
        articleList.add(ArticleModel.fromJson(element));
      });

      loading.value = false;
    }
  }
}
