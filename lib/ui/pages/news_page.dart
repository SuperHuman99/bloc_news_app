import 'package:bloc_news_app/core/blocs/news_bloc/news_bloc.dart';
import 'package:bloc_news_app/core/models/news_model.dart';
import 'package:bloc_news_app/ui/shared/constants.dart';
import 'package:bloc_news_app/ui/shared/widgets/news_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  late ScrollController _newsScrollController;
  int pageNumber = 1;

  @override
  void initState() {
    super.initState();

    _newsScrollController = ScrollController();

    _newsScrollController.addListener(() {
      if (_newsScrollController.position.pixels ==
          _newsScrollController.position.maxScrollExtent) {
        pageNumber++;
        BlocProvider.of<NewsBloc>(context).add(AddMoreNews(page: pageNumber));
      }
    });

    BlocProvider.of<NewsBloc>(context).add(AddNews());
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double contentPadding = 10;
    double cardHeight = 130;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "bloc news app".toUpperCase(),
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: contentPadding, vertical: contentPadding / 2),
        child: BlocBuilder<NewsBloc, NewsState>(
          buildWhen: (previous, current) {
            if ((previous is NewsLoadedState) &&
                (current is NewsLoadErrorState)) {
              return false;
            }
            if ((previous is NewsLoadedState) && (current is NewsLoadedState)) {
              return true;
            }
            return true;
          },
          builder: (context, state) {
            if (state is NewsLoadingState) {
              return const Center(
                child: SizedBox(
                  height: 40,
                  width: 40,
                  child: CircularProgressIndicator(),
                ),
              );
            }

            if (state is NewsLoadedState) {
              return BlocListener<NewsBloc, NewsState>(
                listener: (context, state) {
                  if (state is NewsLoadErrorState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.errorMessage),
                      ),
                    );
                  }
                  if (state is NewsLoadedState) {
                    if (state.loadType == NewsLoadType.updated) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("News Successfully Updated!!"),
                        ),
                      );
                    }
                  }
                },
                child: ListView.builder(
                  controller: _newsScrollController,
                  itemCount: state.news.length,
                  itemBuilder: (context, index) {
                    News news = state.news[index];
                    return NewsCard(
                      cardHeight: cardHeight,
                      screenWidth: screenWidth,
                      contentPadding: contentPadding,
                      news: news,
                    );
                  },
                ),
              );
            }

            if (state is NewsErrorState) {
              return Center(
                child: Text(
                  state.errorMessage,
                  style: const TextStyle(
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                    color: Colors.red,
                  ),
                ),
              );
            }

            return const Center(
              child: Text(
                "Ooops, something went wrong loading the news!",
                style: TextStyle(
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                  color: Colors.red,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
