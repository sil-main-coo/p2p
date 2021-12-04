import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_configuration_module/generated/l10n.dart';
import 'package:p2p_borrower/common/exceptions/api_exception.dart';
import 'package:p2p_borrower/common/exceptions/local_exception.dart';
import 'package:p2p_borrower/domain/usecases/authentication_usecase.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit({required this.authenticationUseCase}) : super(SignUpInitial());

  final AuthenticationUseCase authenticationUseCase;

  Future signUp(String phone, String password, String verifiedCode) async {
    emit(SignUpLoading());

    try {
      final signUpResponse = await authenticationUseCase.signUp(
          phone: phone, password: password, verifiedCode: verifiedCode);
      if (signUpResponse!.isSuccess!) {
        emit(SignUpSuccess(phone: phone, password: password));
      } else {
        emit(SignUpFailure(
            msg: signUpResponse.message ?? SConfig.current.unKnowError));
      }
    } on ApiException catch (apiError) {
      emit(SignUpFailure(msg: apiError.errorMessage));
    } on LocalException catch (localError) {
      emit(SignUpFailure(
          msg: localError.message ?? SConfig.current.deviceError));
    } catch (e) {
      emit(SignUpFailure(msg: SConfig.current.unKnowError));
    }
  }
}
