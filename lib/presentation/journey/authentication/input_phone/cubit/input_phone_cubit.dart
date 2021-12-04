import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_configuration_module/generated/l10n.dart';
import 'package:p2p_borrower/common/exceptions/api_exception.dart';
import 'package:p2p_borrower/common/exceptions/local_exception.dart';
import 'package:p2p_borrower/data/model/response/phone_verify_response.dart';
import 'package:p2p_borrower/domain/usecases/authentication_usecase.dart';

part 'input_phone_state.dart';

class InputPhoneCubit extends Cubit<InputPhoneState> {
  InputPhoneCubit({required this.authenticationUseCase})
      : super(InputPhoneInitial());

  final AuthenticationUseCase authenticationUseCase;

  Future inputPhone(String phone) async {
    emit(InputPhoneLoading());
    try {
      final phoneVerify =
          await authenticationUseCase.checkPhoneExist(phone: phone);

      if (phoneVerify!.isOTPLock! &&
          phoneVerify.lockExpired!.compareTo(DateTime.now()) >= 0) {
        emit(InputPhoneIsExist(
            phone: phone,
            phoneVerifyResponse: phoneVerify,
            lockExpired: phoneVerify.lockExpired,
            isOTPLock: true));
      }

      if (phoneVerify.isInvestorExist! || phoneVerify.isBorrowerExist!) {
        // phone exist
        emit(InputPhoneIsExist(
            phone: phone,
            phoneVerifyResponse: phoneVerify,
            lockExpired: phoneVerify.lockExpired));
      } else {
        emit(InputPhoneNotExist(
            lockExpired: phoneVerify.lockExpired, phone: phone));
      }
    } on ApiException catch (apiError) {
      emit(InputPhoneFailure(msg: apiError.errorMessage));
    } on LocalException catch (localError) {
      emit(InputPhoneFailure(
          msg: localError.message ?? SConfig.current.deviceError));
    } catch (e) {
      debugPrint(e.toString());
      emit(InputPhoneFailure(msg: SConfig.current.unKnowError));
    }
  }
}
