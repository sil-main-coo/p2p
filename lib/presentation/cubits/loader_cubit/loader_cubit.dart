import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'loader_state.dart';

/// inject this cubit into the cubit you want to use loader
/// use bloc listener to listen state of loader
class LoaderCubit extends Cubit<LoaderState> {
  LoaderCubit() : super(LoaderInitial());

  void loading() {
    emit(LoaderLoading());
  }

  void loaded() {
    if (state is LoaderLoading) {
      emit(LoaderLoaded());
    }
  }

  void success({required List<String> messages}) {
    if (state is LoaderLoading) {
      loaded();
      emit(LoaderSuccess(messages: messages));
    }
  }

  void failure({required List<String> messages}) {
    if (state is LoaderLoading) {
      loaded();
      emit(LoaderFailure(messages: messages));
    }
  }
}
