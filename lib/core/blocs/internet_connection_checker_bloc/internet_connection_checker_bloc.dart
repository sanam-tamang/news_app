import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import '../../enum/internet_state_enum.dart';
part 'internet_connection_checker_event.dart';
part 'internet_connection_checker_state.dart';

class InternetConnectionCheckerBloc extends Bloc<InternetConnectionCheckerEvent,
    InternetConnectionCheckerState> {
  final InternetConnectionCheckerPlus internet;
  Stream<InternetConnectionStatus>? _stream;

  InternetConnectionCheckerBloc({required this.internet})
      : super(const InternetConnectionCheckerLoadedState(
            status: InternetStatusEnum.disConnected)) {
    on<ListenInternetStatusEvent>(_onListenInternet);

    _stream = InternetConnectionCheckerPlus().onStatusChange;
    _stream!.listen((status) {

      (add(ListenInternetStatusEvent(status: status)));
    });
  }

  void _onListenInternet(ListenInternetStatusEvent event,
      Emitter<InternetConnectionCheckerState> emit) {
    log("I am in emit");
    if (event.status == InternetConnectionStatus.connected) {
      emit(const InternetConnectionCheckerLoadedState(
          status: InternetStatusEnum.connected));
    }
    if (event.status == InternetConnectionStatus.disconnected) {
      emit(const InternetConnectionCheckerLoadedState(
          status: InternetStatusEnum.disConnected));
    }
  }

  @override
  Future<void> close() {
    _stream?.drain();
    return super.close();
  }
}
