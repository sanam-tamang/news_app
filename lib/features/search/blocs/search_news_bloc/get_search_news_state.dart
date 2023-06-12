// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'get_search_news_bloc.dart';

abstract class GetSearchNewsState extends Equatable {
  const GetSearchNewsState();

  @override
  List<Object> get props => [];
}

class GetSearchNewsInitialState extends GetSearchNewsState {}

class GetSearchNewsLoadingState extends GetSearchNewsState {}

class GetSearchNewsLoadedState extends GetSearchNewsState {
  final NewsFilterationWithPageAndType newsFilteration;
  final List<News> newsList;
  const GetSearchNewsLoadedState({
    required this.newsFilteration,
    required this.newsList,
  });
  @override
  List<Object> get props => [newsList, newsFilteration];
}

class GetSearchNewsFailureState extends GetSearchNewsState {
  final String message;
  const GetSearchNewsFailureState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

