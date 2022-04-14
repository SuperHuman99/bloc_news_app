import 'dart:io';

import 'package:bloc_news_app/core/models/news_model.dart';
import 'package:bloc_news_app/ui/shared/constants.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class NewsRepository {
  Future<List<News>> getOnlineNews({required int id}) async {
    try {
      final url = Uri.parse("$baseUrl" "$id" "$urlCntd");
      final response = await http.get(url);
      var root = jsonDecode(response.body);
      var result = root as Map<dynamic, dynamic>;

      List newsItems = result["results"] as List;

      List<News> news = [];

      for (var item in newsItems) {
        News newsItem = News.fromJson(item);
        news.add(newsItem);
      }
      return news;
    } on SocketException {
      List<News> errorNews = [];
      return errorNews;
    } catch (e) {
      List<News> errorNews = [];
      return errorNews;
    }
  }
}
