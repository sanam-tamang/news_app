import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'get_news_event.dart';
part 'get_news_state.dart';

class GetNewsBloc extends Bloc<GetNewsEvent, GetNewsState> {
  GetNewsBloc() : super(GetNewsInitial()) {
    on<GetNewsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
