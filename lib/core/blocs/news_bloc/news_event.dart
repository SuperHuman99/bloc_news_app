part of 'news_bloc.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object> get props => [];
}

class LoadNews extends NewsEvent {
  const LoadNews({this.news = const <News>[]});

  final List<News> news;

  @override
  List<Object> get props => [news];
}

class AddNews extends NewsEvent {
  AddNews({this.news = const <News>[]});

  List<News> news;

  @override
  List<Object> get props => [news];
}

class AddMoreNews extends NewsEvent {
  AddMoreNews({this.news = const <News>[], required this.page});

  List<News> news;
  final int page;

  @override
  List<Object> get props => [news];
}

class DeleteNews extends NewsEvent {
  const DeleteNews({required this.newsItem});

  final News newsItem;

  @override
  List<Object> get props => [newsItem];
}

class UpdateNews extends NewsEvent {
  const UpdateNews({required this.newsItem, required this.newTitle});

  final News newsItem;
  final String newTitle;

  @override
  List<Object> get props => [newsItem];
}
