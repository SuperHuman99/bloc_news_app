import 'package:bloc/bloc.dart';
import 'package:bloc_news_app/core/models/news_model.dart';
import 'package:bloc_news_app/core/repos/news_repo.dart';
import 'package:bloc_news_app/ui/shared/constants.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository _newsRepository = NewsRepository();

  NewsBloc() : super(const NewsLoadingState()) {
    on<LoadNews>(_onLoadNews);

    on<AddNews>(_onAddNews);

    on<AddMoreNews>(_onAddMoreNews);

    on<DeleteNews>(_onDeleteTodos);

    on<UpdateNews>(_onUpdateNews);
  }

  void _onLoadNews(LoadNews event, Emitter<NewsState> emit) {
    emit(const NewsLoadingState());
  }

  void _onAddNews(AddNews event, Emitter<NewsState> emit) async {
    final state = this.state;
    if (state is NewsLoadingState) {
      try {
        List<News> fetchedNews = await _newsRepository.getOnlineNews(id: 1);
        event.news = fetchedNews;
        if (fetchedNews.isEmpty) {
          emit(
            const NewsLoadErrorState(
                errorMessage: "Sorry! Could not load news from online !"),
          );
          return;
        }
        emit(
          NewsLoadedState(
              news: List.from(state.news)..addAll(event.news),
              loadType: NewsLoadType.none),
        );
      } catch (e) {
        emit(
          const NewsErrorState(
              errorMessage: "Sorry! Could not load news from online !"),
        );
      }
    }
  }

  void _onAddMoreNews(AddMoreNews event, Emitter<NewsState> emit) async {
    final state = this.state;
    if (state is NewsLoadedState) {
      try {
        List<News> fetchedNews =
            await _newsRepository.getOnlineNews(id: event.page);
        event.news = fetchedNews;
        if (fetchedNews.isEmpty) {
          emit(
            const NewsLoadErrorState(
                errorMessage: "Sorry! Could not load news from online !"),
          );
        }
        emit(
          NewsLoadedState(
              news: List.from(state.news)..addAll(event.news),
              loadType: NewsLoadType.none),
        );
      } catch (e) {
        emit(
          const NewsErrorState(
              errorMessage: "Sorry! Could not load news from online !"),
        );
      }
    }
  }

  void _onDeleteTodos(DeleteNews event, Emitter<NewsState> emit) {
    final state = this.state;
    if (state is NewsLoadedState) {
      emit(NewsLoadedState(
        news: List.from(state.news)..remove(event.newsItem),
        loadType: NewsLoadType.deleted,
      ));
    }
  }

  void _onUpdateNews(UpdateNews event, Emitter<NewsState> emit) {
    final state = this.state;
    if (state is NewsLoadedState) {
      List<News> existingNews = List.from(state.news);
      int newsIndex = existingNews.indexOf(event.newsItem);
      emit(
        NewsLoadedState(
          news: List.from(state.news)
            ..replaceRange(newsIndex, newsIndex + 1,
                [event.newsItem.copyWith(newTitle: event.newTitle)]),
          loadType: NewsLoadType.updated,
        ),
      );
    }
  }
}
