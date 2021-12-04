part of 'notification_cubit.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();
}

class NotificationInitial extends NotificationState {
  @override
  List<Object> get props => [];
}

class NotificationDone extends NotificationState {
  @override
  List<Object> get props => [];
}

class NotificationAlert extends NotificationState {
  final List<dynamic>? listDataMessage;

  NotificationAlert({this.listDataMessage});

  NotificationAlert copyWith({String? msg}) {
    return NotificationAlert(listDataMessage: listDataMessage);
  }

  @override
  List<Object> get props => [if (listDataMessage != null) this.listDataMessage!];
}
