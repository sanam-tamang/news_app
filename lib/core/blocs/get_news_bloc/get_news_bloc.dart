import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/exception_and_failure/exception.dart';

import 'package:news_app/core/repositories/news_repository.dart';

import '../../../../core/blocs/model.dart';
import '../../../../core/exception_and_failure/failure_message.dart';
import '../../../../core/model/news.dart';

part 'get_news_event.dart';
part 'get_news_state.dart';

class GetNewsBloc extends Bloc<GetNewsEvent, GetNewsState> {
  final NewsRepository _repository;
  GetNewsBloc({required NewsRepository repository})
      : _repository = repository,
        super(GetNewsLoadingState()) {
    on<GetNewsListEvent>(_onGetNewsEvent);
    on<GetNewsListWithPageEvent>(_onGetnewsWithPage);
  }

  FutureOr<void> _onGetNewsEvent(GetNewsListEvent event, Emitter<GetNewsState> emit) async {
    try {
      final List<News> newsList = await _repository
          .getNews(GetNewsFilterationParam(newsType: event.newsType));

      emit(GetNewsLoadedState(
          newsList: newsList,
          newsFilteration: NewsFilterationWithPageAndType(
              currentNewsType: event.newsType, currentPage: 1)));
    } on AuthorizationUserException {
      emit(const GetNewsFailureState(message: FailureMessage.authFailureMsg));
    } on ServerException {
      emit(const GetNewsFailureState(message: FailureMessage.serverFailureMsg));
    }
  }

  FutureOr<void> _onGetnewsWithPage(
      GetNewsListWithPageEvent event, Emitter<GetNewsState> emit) async {
    final state = this.state;
    if (state is GetNewsLoadedState){
      int newPageToGet = state.newsFilteration.currentPage+1;
      try {
        final List<News> newsList = await _repository
            .getNews(GetNewsFilterationParam(newsType: state.newsFilteration.currentNewsType, page:newPageToGet ));

        emit(GetNewsLoadedState(
            newsList: newsList,
            newsFilteration: NewsFilterationWithPageAndType(
                currentNewsType: state.newsFilteration.currentNewsType, currentPage: newPageToGet)));
      } on AuthorizationUserException {
        emit(const GetNewsFailureState(message: FailureMessage.authFailureMsg));
      } on ServerException {
        emit(const GetNewsFailureState(
            message: FailureMessage.serverFailureMsg));
      }
    }
     
  }
}
