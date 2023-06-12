// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'get_search_news_bloc.dart';

abstract class GetSearchNewsEvent extends Equatable {
  const GetSearchNewsEvent();

  @override
  List<Object> get props => [];
}

class GetSearchNewsListEvent extends GetSearchNewsEvent {
  final String newsType;
 const  GetSearchNewsListEvent({
    required this.newsType,
  });


  @override
  List<Object> get props => [newsType];
}



class GetSearchNewsListWithPageEvent extends GetSearchNewsEvent {
}


class ClearSearchNewsListEvent extends GetSearchNewsEvent{}
