part of 'home_cubit.dart';

@immutable
abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeLoading extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeLoaded extends HomeState {
  final List<LoanProductsResponse>? loanProducts;

  HomeLoaded({this.loanProducts});

  @override
  List<Object?> get props => [loanProducts];
}

class HomeFailure extends HomeState {
  final String msg;

  const HomeFailure({required this.msg});

  @override
  List<Object> get props => [msg];
}
