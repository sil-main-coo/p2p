part of 'connect_social_cubit.dart';

abstract class ConnectSocialState extends Equatable {
  const ConnectSocialState();
}

class ConnectSocialInitial extends ConnectSocialState {
  @override
  List<Object> get props => [];
}

class ConnectSocialLoading extends ConnectSocialState {
  @override
  List<Object> get props => [];
}

class ConnectSocialLogged extends ConnectSocialState {
  final FacebookInfoResponse fbProfile;

  ConnectSocialLogged({required this.fbProfile});

  @override
  List<Object> get props => [fbProfile];
}

class ConnectSocialLoggedOut extends ConnectSocialState {
  @override
  List<Object> get props => [];
}
