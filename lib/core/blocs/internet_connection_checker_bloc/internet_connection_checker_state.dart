part of 'internet_connection_checker_bloc.dart';

abstract class InternetConnectionCheckerState extends Equatable {
  const InternetConnectionCheckerState();

  @override
  List<Object> get props => [];
}

class InternetConnectionCheckerInitial extends InternetConnectionCheckerState {}

class InternetConnectionCheckerLoadedState
    extends InternetConnectionCheckerState {
  final InternetStatusEnum status;

 const InternetConnectionCheckerLoadedState({required this.status});

  @override
  List<Object> get props => [status];
}
