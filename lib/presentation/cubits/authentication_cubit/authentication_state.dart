part of 'authentication_cubit.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
}

class AuthenticationInitial extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class AuthenticationLoading extends AuthenticationState {
  @override
  List<Object> get props => [];
}

// the there is a valid token
class AuthenticatedAndNotSignIn extends AuthenticationState {
  final String phone;

  AuthenticatedAndNotSignIn({required this.phone});

  @override
  List<Object> get props => [phone];
}

// the there is a valid token
class AuthenticatedAndSignedIn extends AuthenticationState {
  final String token;
  final String phone;
  final User user;
  final bool autoPush;

  AuthenticatedAndSignedIn(
      {required this.token,
      required this.phone,
      required this.user,
      required this.autoPush});

  @override
  List<Object> get props => [token, phone, user, autoPush];
}

class UnAuthenticated extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class SignedOutFailed extends AuthenticationState {
  final List<dynamic>? listDataMessage;

  SignedOutFailed({this.listDataMessage});

  SignedOutFailed copyWith({String? msg}) {
    return SignedOutFailed(listDataMessage: listDataMessage);
  }

  @override
  List<Object> get props =>
      [if (listDataMessage != null) this.listDataMessage!];
}

class AuthenticatedFailed extends AuthenticationState {
  final List<dynamic>? listDataMessage;

  AuthenticatedFailed({this.listDataMessage});

  AuthenticatedFailed copyWith({String? msg}) {
    return AuthenticatedFailed(listDataMessage: listDataMessage);
  }

  @override
  List<Object> get props =>
      [if (listDataMessage != null) this.listDataMessage!];
}
