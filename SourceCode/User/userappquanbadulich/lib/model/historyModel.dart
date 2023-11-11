class HistoryModel {
  final String idHistoryStory;
  final String titleStoryStory;
  final String contentStoryStory;
  final String? avatarHistory;
  final String? imgHistory;
  final String? videoHistory;

  HistoryModel({
    required this.idHistoryStory,
    required this.titleStoryStory,
    required this.contentStoryStory,
    required this.avatarHistory,
    required this.imgHistory,
    required this.videoHistory,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(
      idHistoryStory: json['idHistoryStory'],
      titleStoryStory: json['titleStoryStory'],
      contentStoryStory: json['contentStoryStory'],
      imgHistory: json['imgHistory'],
      avatarHistory: json['avatarHistory'],
      videoHistory: json['videoHistory'],
    );
  }
}
