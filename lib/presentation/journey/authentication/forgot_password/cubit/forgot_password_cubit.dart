import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_configuration_module/generated/l10n.dart';
import 'package:p2p_borrower/common/exceptions/api_exception.dart';
import 'package:p2p_borrower/common/exceptions/local_exception.dart';
import 'package:p2p_borrower/domain/usecases/authentication_usecase.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit({required this.authenticationUseCase})
      : super(ForgotPasswordInitial());

  final AuthenticationUseCase authenticationUseCase;

  Future forgotPassword(
      String phone, String password, String verifiedCode) async {
    emit(ForgotPasswordLoading());

    try {
      final forgotPWDResponse = await authenticationUseCase.forgotPassword(
          phone: phone, newPassword: password, verifiedCode: verifiedCode);
      if (forgotPWDResponse!.isSuccess!) {
        emit(ForgotPasswordSuccess(phone: phone, password: password));
      } else {
        emit(ForgotPasswordFailure(
            msg: forgotPWDResponse.message ?? SConfig.current.unKnowError));
      }
    } on ApiException catch (apiError) {
      emit(ForgotPasswordFailure(msg: apiError.errorMessage));
    } on LocalException catch (localError) {
      emit(ForgotPasswordFailure(
          msg: localError.message ?? SConfig.current.deviceError));
    } catch (e) {
      emit(ForgotPasswordFailure(msg: SConfig.current.unKnowError));
    }
  }
}
