class HistoryModel {
  final String historyStory;
  final String? imgHistory;
  final String? videoHistory;

  HistoryModel({
    required this.historyStory,
    required this.imgHistory,
    required this.videoHistory,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(
      historyStory: json['historyStory'],
      imgHistory: json['imgHistory'],
      videoHistory: json['videoHistory'],
    );
  }
}
