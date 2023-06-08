import 'package:tech_blog/component/api_url.dart';

class ArticleModel {
  String? id;
  String? title;
  String? image;
  String? catId;
  String? catname;
  String? author;
  String? view;
  String? status;
  // bool? isFavorite;
  String? createdAt;

  ArticleModel({
    this.id,
    this.title,
    this.image,
    this.catId,
    this.catname,
    this.author,
    this.view,
    this.status,
    // this.isFavorite,
    this.createdAt,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      id: json['id'],
      title: json['title'],
      image: ApiUrl.hostDlUrl + json['image'],
      catId: json['cat_id'],
      catname: json['cat_name'],
      author: json['author'] ?? 'نامشخص',
      view: json['view'],
      status: json['status'],
      // isFavorite: json['isFavorite'],
      createdAt: json['created_at'],
    );
  }
}
