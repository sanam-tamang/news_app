import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/exception_and_failure/exception.dart';

import '../../../../core/repositories/news_repository.dart';

import '../../../../core/blocs/model.dart';
import '../../../../core/exception_and_failure/failure_message.dart';
import '../../../../core/model/news.dart';

part 'get_search_new_event.dart';
part 'get_search_news_state.dart';

class GetSearchNewsBloc extends Bloc<GetSearchNewsEvent, GetSearchNewsState> {
  final NewsRepository _repository;
  GetSearchNewsBloc({required NewsRepository repository})
      : _repository = repository,
        super(GetSearchNewsInitialState()) {
    on<GetSearchNewsListEvent>(_onGetNewsEvent);
    on<GetSearchNewsListWithPageEvent>(_onGetnewsWithPage);
    on<ClearSearchNewsListEvent>(_onClearSearchEvent);
  }

  FutureOr<void> _onGetNewsEvent(
      GetSearchNewsListEvent event, Emitter<GetSearchNewsState> emit) async {
    try {
      emit(GetSearchNewsLoadingState());
      final List<News> newsList = await _repository
          .getNews(GetNewsFilterationParam(newsType: event.newsType));

      emit(GetSearchNewsLoadedState(
          newsList: newsList,
          newsFilteration: NewsFilterationWithPageAndType(
              currentNewsType: event.newsType, currentPage: 1)));
    } on AuthorizationUserException {
      emit(const GetSearchNewsFailureState(
          message: FailureMessage.authFailureMsg));
    } on ServerException {
      emit(const GetSearchNewsFailureState(
          message: FailureMessage.serverFailureMsg));
    } on SocketException {
      emit(const GetSearchNewsFailureState(message: ''));
    } on ServerUpgradationRequired426And429 {
      emit(const GetSearchNewsFailureState(
          message: FailureMessage.updrationRequired426And429));
    }
  }

  FutureOr<void> _onGetnewsWithPage(GetSearchNewsListWithPageEvent event,
      Emitter<GetSearchNewsState> emit) async {
    final state = this.state;
    if (state is GetSearchNewsLoadedState) {
      emit(GetSearchNewsLoadingState());
      int newPageToGet = state.newsFilteration.currentPage + 1;
      try {
        final List<News> newsList = await _repository.getNews(
            GetNewsFilterationParam(
                newsType: state.newsFilteration.currentNewsType,
                page: newPageToGet));

        if (newsList.length < newsRepoPageSize) {
          log(" klength ${newsList.length} finished ");
          GetSearchNewsLoadedState(
              newsList: List.from(state.newsList),
              newsFilteration: NewsFilterationWithPageAndType(
                  currentNewsType: state.newsFilteration.currentNewsType,
                  currentPage: state.newsFilteration.currentPage));
          return;
        }

        emit(GetSearchNewsLoadedState(
            newsList: List.from(state.newsList)..addAll(newsList),
            newsFilteration: NewsFilterationWithPageAndType(
                currentNewsType: state.newsFilteration.currentNewsType,
                currentPage: newPageToGet)));
      } on AuthorizationUserException {
        emit(const GetSearchNewsFailureState(
            message: FailureMessage.authFailureMsg));
      } on ServerException {
        emit(const GetSearchNewsFailureState(
            message: FailureMessage.serverFailureMsg));
      } on SocketException {
        emit(const GetSearchNewsFailureState(message: ''));
      } on ServerUpgradationRequired426And429 {
        emit(const GetSearchNewsFailureState(
            message: FailureMessage.updrationRequired426And429));
      }
    }
  }

  void _onClearSearchEvent(
      ClearSearchNewsListEvent event, Emitter<GetSearchNewsState> emit) {
    emit(GetSearchNewsInitialState());
  }
}
