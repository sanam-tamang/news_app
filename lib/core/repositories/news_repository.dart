// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import 'package:news_app/core/exception_and_failure/exception.dart';

import '../model/news.dart';

const String apiKey = "61b6946b9872402bb11894b84fe0d736";
const int newsRepoPageSize = 10;

class NewsRepository {
  final http.Client client;
  NewsRepository({
    required this.client,
  });
  Future<List<News>> getNews(GetNewsFilterationParam param) async {
    String newsUrl =
        "https://newsapi.org/v2/everything?q=${param.newsType}&sortBy=publishedAt&page=${param.page}&pageSize=$newsRepoPageSize";

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
    } else if (response.statusCode == 426 || response.statusCode == 429) {
      throw ServerUpgradationRequired426And429();
    } else {
      log("status code is  ${response.statusCode}");
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
