import 'package:equatable/equatable.dart';

class News extends Equatable {
  late String title;
  late String abstract;
  late List<String> tags;
  late String mediaImageUrl;
  late String newsDetailUrl;

  News({
    required this.title,
    required this.abstract,
    required this.mediaImageUrl,
    required this.tags,
    required this.newsDetailUrl,
  });

  News.fromJson(Map<String, dynamic> data) {
    title = data["title"];
    abstract = data["abstract"];
    mediaImageUrl = (data["media"] as List).isEmpty
        ? "empty"
        : data["media"][0]["media-metadata"][0]["url"];
    tags = data["adx_keywords"].toString().split(";");
    newsDetailUrl = data["url"];
  }

  News copyWith({String? newTitle}) {
    return News(
      title: newTitle ?? title,
      abstract: abstract,
      tags: tags,
      newsDetailUrl: newsDetailUrl,
      mediaImageUrl: mediaImageUrl,
    );
  }

  @override
  List<Object> get props => [
        title,
        abstract,
        tags,
        mediaImageUrl,
      ];
}
