import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:tech_blog/component/my_app_bar.dart';
import 'package:tech_blog/controller/article/manage_article_controller.dart';

class ArticleContentEditor extends StatelessWidget {
  ArticleContentEditor({super.key});

  final HtmlEditorController controller = HtmlEditorController();
  final manageArticleController = Get.find<ManageArticleController>();

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () {
        controller.clearFocus();
      },
      child: Scaffold(
        appBar: myAppBar(textTheme, 'نوشتن/ویرایش مقاله'),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HtmlEditor(
                controller: controller,
                htmlEditorOptions: HtmlEditorOptions(
                  hint: 'میتونی مقالتو اینجا بنویسی',
                  shouldEnsureVisible: true,
                  initialText:
                      manageArticleController.articleInfoModel.value.content,
                ),
                callbacks: Callbacks(
                  onChangeContent: (value) {
                    manageArticleController.articleInfoModel.update((val) {
                      val!.content = value;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
