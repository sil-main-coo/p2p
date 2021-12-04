import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_configuration_module/generated/l10n.dart';
import 'package:p2p_borrower/common/exceptions/api_exception.dart';
import 'package:p2p_borrower/common/exceptions/local_exception.dart';
import 'package:p2p_borrower/data/model/response/sign_in_response.dart';
import 'package:p2p_borrower/domain/usecases/authentication_usecase.dart';
import 'package:p2p_borrower/presentation/cubits/authentication_cubit/authentication_cubit.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit(
      {required this.authenticationUseCase, required this.authenticationCubit})
      : super(SignInInitial());

  final AuthenticationUseCase authenticationUseCase;
  final AuthenticationCubit authenticationCubit;

  Future signIn(String phone, String password, {bool autoPush = true}) async {
    emit(SignInLoading());

    try {
      final signInResponse =
          await authenticationUseCase.signIn(phone: phone, password: password);
      if (signInResponse!.isSuccess == null) {
        // sign in success -> save token and phone to local storage
        await authenticationCubit.signedIn(
            accessToken:
                signInResponse.authenticationToken!.accessToken!.token!,
            refreshToken:
                signInResponse.authenticationToken!.refreshToken!.token!,
            userName: phone,
            user: signInResponse.user!,
            autoPush: autoPush);
        emit(SignInSuccess(signInResponse: signInResponse));
      } else {
        emit(SignInFailure(
            msg: signInResponse.message ?? SConfig.current.unKnowError));
      }
    } on ApiException catch (apiError) {
      emit(SignInFailure(msg: apiError.errorMessage));
    } on LocalException catch (localError) {
      emit(SignInFailure(
          msg: localError.message ?? SConfig.current.deviceError));
    } catch (e) {
      emit(SignInFailure(msg: SConfig.current.unKnowError));
    }
  }
}
