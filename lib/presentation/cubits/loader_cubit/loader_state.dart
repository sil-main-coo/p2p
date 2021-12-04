part of 'loader_cubit.dart';

abstract class LoaderState extends Equatable {
  const LoaderState();
}

class LoaderInitial extends LoaderState {
  @override
  List<Object> get props => [];
}

class LoaderLoading extends LoaderState {
  @override
  List<Object> get props => [];
}

class LoaderSuccess extends LoaderState {
  final List<String> messages;

  LoaderSuccess({required this.messages});

  @override
  List<Object> get props => [messages];
}

class LoaderLoaded extends LoaderState {
  @override
  List<Object> get props => [];
}

class LoaderFailure extends LoaderState {
  final List<String> messages;

  LoaderFailure({required this.messages});

  @override
  List<Object> get props => [messages];
}
