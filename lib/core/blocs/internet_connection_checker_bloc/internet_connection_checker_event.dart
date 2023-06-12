// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'internet_connection_checker_bloc.dart';

abstract class InternetConnectionCheckerEvent extends Equatable {
  const InternetConnectionCheckerEvent();

  @override
  List<Object> get props => [];
}

class ListenInternetStatusEvent extends InternetConnectionCheckerEvent {
  final InternetConnectionStatus status;
 const  ListenInternetStatusEvent({
    required this.status,
  });
}
