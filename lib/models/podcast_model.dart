import 'package:tech_blog/component/api_url.dart';

class PodcastModel {
  String id;
  String title;
  String poster;
  String author;
  String view;
  String createdAt;

  PodcastModel({
    required this.id,
    required this.title,
    required this.poster,
    required this.author,
    required this.view,
    required this.createdAt,
  });

  factory PodcastModel.fromJson(Map<String, dynamic> json) {
    return PodcastModel(
      id: json['id'],
      title: json['title'],
      poster: ApiUrl.hostDlUrl + json['poster'],
      author: json['author'] ?? '',
      view: json['view'],
      createdAt: json['created_at'],
    );
  }
}
