class PodcastFileModel {
  String? id;
  String? podcastId;
  String? file;
  String? title;
  String? length;

  PodcastFileModel();

  PodcastFileModel.fromJson(Map<String, dynamic> element) {
    id = element['id'];
    podcastId = element['podcast_id'];
    file = element['file'];
    title = element['title'];
    length = element['length'];
  }
}



//  "id": "2",
//             "podcast_id": "2",
//             "file": "/Techblog/assets/upload/images/podcast/files/20221201165930.mp3",
//             "title": "پادکست خانه ترید",
//             "length": "15"