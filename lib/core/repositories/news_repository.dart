// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:news_app/core/exception/exception.dart';

import '../model/news.dart';

const String apiKey = "21b719eb317347ee9a8a46760aa3c4e6";

class NewsRepository {
  final http.Client client;
  NewsRepository({
    required this.client,
  });
  Future<List<News>> getNews(GetNewsFilterationParam param) async {
    String newsUrl =
        "https://newsapi.org/v2/everything?q=${param.newsType}&sortBy=publishedAt&page=${param.page}";

    final response = await client
        .get(Uri.parse(newsUrl), headers: {'authorization': 'Bearer $apiKey'});

    if (response.statusCode == 200) {
      final parsedData = jsonDecode(response.body);

      final List<News> newsList = List.from(parsedData['articles'])
          .map((e) => News.fromJson(e))
          .toList();

      return newsList;
    } else if (response.statusCode == 401) {
      throw AuthorizationUserException();
    } else {
      throw ServerException();
    }
  }
}

class GetNewsFilterationParam {
  final String newsType;
  GetNewsFilterationParam({
    required this.newsType,
    this.page = 1,
  });
  final int page;
}
