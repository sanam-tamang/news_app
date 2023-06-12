part of 'get_news_bloc.dart';

abstract class GetNewsState extends Equatable {
  const GetNewsState();
  
  @override
  List<Object> get props => [];
}

class GetNewsInitial extends GetNewsState {}
