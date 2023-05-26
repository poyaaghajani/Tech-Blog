import 'package:tech_blog/component/api_url.dart';

class PosterModel {
  String? id;
  String? title;
  String? image;

  PosterModel({
    this.id,
    this.title,
    this.image,
  });

  factory PosterModel.fromJson(Map<String, dynamic> json) {
    return PosterModel(
      id: json["id"],
      title: json["title"],
      image: ApiUrl.hostDlUrl + json["image"],
    );
  }
}
