// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'get_news_bloc.dart';

abstract class GetNewsState extends Equatable {
  const GetNewsState();

  @override
  List<Object> get props => [];
}

class GetNewsInititalState extends GetNewsState {}

class GetNewsLoadingState extends GetNewsState {}

class GetNewsLoadedState extends GetNewsState {
  final NewsFilterationWithPageAndType newsFilteration;
  final List<News> newsList;
  final FetchWithPageEnum fetchWithPage;
  const GetNewsLoadedState({
    required this.newsFilteration,
    required this.newsList,
    required this.fetchWithPage,
  });
  @override
  List<Object> get props => [newsList, newsFilteration];
}

class GetNewsFailureState extends GetNewsState {
  final String message;
  const GetNewsFailureState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}
