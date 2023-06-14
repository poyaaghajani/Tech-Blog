import 'package:get/get.dart';
import 'package:tech_blog/main.dart';
import 'package:tech_blog/view/article_screens/manage_article.dart';
import 'package:tech_blog/view/article_screens/single_article.dart';
import 'package:tech_blog/view/article_screens/single_manage_article.dart';
import 'package:tech_blog/route/binding.dart';
import 'package:tech_blog/view/main_screens/main_screen.dart';
import 'package:tech_blog/view/podcast_screens/single_podcast.dart';
import 'package:tech_blog/view/splash_screen.dart';

class Pages {
  Pages._();

  static List<GetPage> pages = [
    GetPage(
      name: NamedRoute.routeInitial,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: NamedRoute.routeMainScreen,
      page: () => MainScreen(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: NamedRoute.routeSingleArticle,
      page: () => SingleArticleScreen(),
      binding: ArticleBinding(),
    ),
    GetPage(
      name: NamedRoute.manageArticle,
      page: () => const ManageArticle(),
      binding: ArticleManagerBinding(),
    ),
    GetPage(
      name: NamedRoute.manageArticle,
      page: () => const ManageArticle(),
      binding: ArticleManagerBinding(),
    ),
    GetPage(
      name: NamedRoute.singleManageArticle,
      page: () => SingleManageArticle(),
      binding: ArticleManagerBinding(),
    ),
    GetPage(
      name: NamedRoute.singlePodcast,
      page: () => SinglePodcast(),
    ),
  ];
}
