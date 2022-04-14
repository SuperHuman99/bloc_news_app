import 'package:bloc_news_app/core/models/news_model.dart';
import 'package:flutter/cupertino.dart';

const String baseUrl =
    "http://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/";

const String urlCntd = ".json?api-key=$apiKey";

const String noImageUrl =
    "https://images.unsplash.com/photo-1628155930542-3c7a64e2c833?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1974&q=80";

const String apiKey = "0sKNTnLGyPghpibXDIayDogYuuk7BiTw";

// app colours Color.fromARGB(255, 0, 140, 255)
const Color primaryColor = Color.fromARGB(255, 0, 140, 255);
const Color secondaryColor = Color.fromARGB(255, 0, 247, 255);

// enums
enum NewsLoadType {
  updated,
  deleted,
  none,
}

// dummies
List<News> dummies = [
  News(
    title: "News 1 Title".toUpperCase(),
    abstract: "This is the abstract of the news named News 1",
    mediaImageUrl: noImageUrl,
    tags: const ["tag 1", "tag 2"],
    newsDetailUrl: "https://www.google.com/",
  ),
  News(
    title: "News 2 Title".toUpperCase(),
    abstract: "This is the abstract of the news named News 1",
    mediaImageUrl: noImageUrl,
    tags: const ["tag 1", "tag 2"],
    newsDetailUrl: "https://www.google.com/",
  ),
  News(
    title: "News 3 Title".toUpperCase(),
    abstract: "This is the abstract of the news named News 1",
    mediaImageUrl: noImageUrl,
    tags: const ["tag 1", "tag 2"],
    newsDetailUrl: "https://www.google.com/",
  ),
  News(
    title: "News 4 Title".toUpperCase(),
    abstract: "This is the abstract of the news named News 1",
    mediaImageUrl: noImageUrl,
    tags: const ["tag 1", "tag 2"],
    newsDetailUrl: "https://www.google.com/",
  ),
];
