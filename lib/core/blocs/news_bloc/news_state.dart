part of 'news_bloc.dart';

abstract class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object> get props => [];
}

class NewsLoadingState extends NewsState {
  final List<News> news;

  const NewsLoadingState({this.news = const <News>[]});

  @override
  List<Object> get props => [news];
}

class NewsLoadedState extends NewsState {
  final List<News> news;
  final NewsLoadType loadType;

  const NewsLoadedState({this.news = const <News>[], required this.loadType});

  @override
  List<Object> get props => [news];
}

class NewsErrorState extends NewsState {
  final String errorMessage;

  const NewsErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

class NewsLoadErrorState extends NewsState {
  final String errorMessage;

  const NewsLoadErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

class NewsDeletedState extends NewsState {
  final String message;

  const NewsDeletedState({required this.message});

  @override
  List<Object> get props => [message];
}
