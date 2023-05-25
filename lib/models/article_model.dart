class ArticleModel {
  String id;
  String title;
  String image;
  String catId;
  String catname;
  String author;
  String view;
  String createdAt;

  ArticleModel({
    required this.id,
    required this.title,
    required this.image,
    required this.catId,
    required this.catname,
    required this.author,
    required this.view,
    required this.createdAt,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      catId: json['cat_id'],
      catname: json['cat_name'],
      author: json['author'],
      view: json['view'],
      createdAt: json['created_at'],
    );
  }
}
