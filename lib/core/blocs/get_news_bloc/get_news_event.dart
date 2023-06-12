// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'get_news_bloc.dart';

abstract class GetNewsEvent extends Equatable {
  const GetNewsEvent();

  @override
  List<Object> get props => [];
}

class GetNewsListEvent extends GetNewsEvent {
  final String newsType;
 const  GetNewsListEvent({
    required this.newsType,
  });


  @override
  List<Object> get props => [newsType];
}



class GetNewsListWithPageEvent extends GetNewsEvent {



  
}

