import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../exception_and_failure/exception.dart';

import '../../repositories/news_repository.dart';

import '../../../../core/blocs/model.dart';
import '../../../../core/exception_and_failure/failure_message.dart';
import '../../../../core/model/news.dart';
import '../../enum/fetch_data_with_page.dart';

part 'get_news_event.dart';
part 'get_news_state.dart';

class GetNewsBloc extends Bloc<GetNewsEvent, GetNewsState> {
  final NewsRepository _repository;
  GetNewsBloc({required NewsRepository repository})
      : _repository = repository,
        super(GetNewsInititalState()) {
    on<GetNewsListEvent>(_onGetNewsEvent);
    on<GetNewsListWithPageEvent>(_onGetnewsWithPage);
  }

  FutureOr<void> _onGetNewsEvent(
      GetNewsListEvent event, Emitter<GetNewsState> emit) async {
        
    try {
      final List<News> newsList = await _repository
          .getNews(GetNewsFilterationParam(newsType: event.newsType));
      final loadedState = GetNewsLoadedState(
          newsList: newsList,
          newsFilteration: NewsFilterationWithPageAndType(
              currentNewsType: event.newsType, currentPage: 1),
          fetchWithPage: FetchWithPageEnum.hasFurtherDataToFetch);
      emit(loadedState);
    } on AuthorizationUserException {
      emit(const GetNewsFailureState(message: FailureMessage.authFailureMsg));
    } on ServerException {
      emit(const GetNewsFailureState(message: FailureMessage.serverFailureMsg));
    } on SocketException {
      emit(const GetNewsFailureState(message: ''));
    } on ServerUpgradationRequired426And429 {
           emit(const GetNewsFailureState(message: FailureMessage.updrationRequired426And429));

    }
  }

  FutureOr<void> _onGetnewsWithPage(
      GetNewsListWithPageEvent event, Emitter<GetNewsState> emit) async {
    final state = this.state;
    if (state is GetNewsLoadedState) {
      int newPageToGet = state.newsFilteration.currentPage + 1;
      final onErrorLoadedState = GetNewsLoadedState(
          newsList: List.from(state.newsList),
          newsFilteration: NewsFilterationWithPageAndType(
              currentNewsType: state.newsFilteration.currentNewsType,
              currentPage: state.newsFilteration.currentPage),
          fetchWithPage: FetchWithPageEnum.hasNotFurtherDataToFetch);
      try {
        final List<News> newsList = await _repository.getNews(
            GetNewsFilterationParam(
                newsType: state.newsFilteration.currentNewsType,
                page: newPageToGet));

        ///if there is not data left in server
        if (newsList.length < newsRepoPageSize) {
          log(" klength of dd ${newsList.length} finished ");
          emit(onErrorLoadedState);
          return;
        }

        emit(GetNewsLoadedState(
            newsList: List.from(state.newsList)..addAll(newsList),
            newsFilteration: NewsFilterationWithPageAndType(
              currentNewsType: state.newsFilteration.currentNewsType,
              currentPage: newPageToGet,
            ),
            fetchWithPage: FetchWithPageEnum.hasFurtherDataToFetch));
      } on AuthorizationUserException {
        emit(const GetNewsFailureState(message: FailureMessage.authFailureMsg));
      } on ServerException {
        emit(const GetNewsFailureState(
            message: FailureMessage.serverFailureMsg));
      } on SocketException {
        emit(const GetNewsFailureState(message: ''));
      } on ServerUpgradationRequired426And429 {
        emit(onErrorLoadedState);
      }
    }
  }
}
