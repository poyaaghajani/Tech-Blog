class PosterModel {
  String id;
  String title;
  String image;

  PosterModel({
    required this.id,
    required this.title,
    required this.image,
  });

  factory PosterModel.fromJson(Map<String, dynamic> json) {
    return PosterModel(
      id: json["id"],
      title: json["title"],
      image: json["image"],
    );
  }
}
