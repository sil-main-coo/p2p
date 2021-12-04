import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:flutter_configuration_module/utility/extentions/string_extension.dart';
import 'package:p2p_borrower/common/constants/app_default_constants.dart';
import 'package:p2p_borrower/generated/l10n.dart';
import 'package:p2p_borrower/presentation/journey/authentication/verify_otp/otp_cubit/otp_constants.dart';

part 'validator_state.dart';

class ValidatorCubit extends Cubit<ValidatorState> {
  int fieldsTotal;

  ValidatorCubit({this.fieldsTotal = 1}) : super(ValidatorCurrentState.init()) {
    _errors = List.generate(fieldsTotal, (index) => '');
  }

  late List<String?> _errors;

  void validatePhoneReference(String value, String phone) {
    emit(ValidatorCurrentState.init());
    if (value.isEmpty) {
      _errors[0] = S.current.phoneReferenceValidEmpty;
      emit(ValidatorCurrentState.failure(errors: _errors));
      return;
    }

    if (value == phone) {
      _errors[0] = S.current.phoneReferenceValidEqualPhoneLogin;
      emit(ValidatorCurrentState.failure(errors: _errors));
      return;
    }

    if (value.isNewVietnamPhoneNumber) {
      emit(ValidatorCurrentState.success(value: value));
      return;
    }

    if (value.isOldVietnamNumberPhone) {
      _errors[0] = S.current.MSG12;
      emit(ValidatorCurrentState.failure(errors: _errors));
      return;
    }
    _errors[0] = S.current.MSG03A;
    emit(ValidatorCurrentState.failure(errors: _errors));
  }

  /// Method: validate phone input
  void validatePhoneNumber(String value) {
    if (value.isEmpty) {
      emit(ValidatorCurrentState.init());
      return;
    }

    if (value.isNewVietnamPhoneNumber) {
      emit(ValidatorCurrentState.success(value: value));
      return;
    }

    if (value.isOldVietnamNumberPhone) {
      _errors[0] = S.current.MSG12;
      emit(ValidatorCurrentState.failure(errors: _errors));
      return;
    }

    _errors[0] = S.current.MSG03A;
    emit(ValidatorCurrentState.failure(errors: _errors));
  }

  /// Method: validate otp value
  void validateVerifyOtp(String value) {
    if (value.length == OTPConstants.lengthCode && value.isAllNumeric) {
      emit(ValidatorCurrentState.success(value: value));
      return;
    }

    emit(ValidatorCurrentState.init());
  }

  /// Method: validate input password field
  void validateInputPassword(String password) {
    // catch password
    if (!_isPassword(password)) {
      _errors[0] = S.current.MSG09;
      emit(ValidatorCurrentState.failure(errors: _errors));
      return;
    }
    // success
    emit(ValidatorCurrentState.success(
        value: password, errors: _errors..[0] = ''));
  }

  /// Method: validate password field
  void validateConfirmPassword(String password, String confirmPassword) {
    // catch password
    if (!_isPassword(password)) {
      _errors[0] = S.current.MSG09;
      emit(ValidatorCurrentState.failure(errors: _errors));
      return;
    } else {
      // success
      emit(ValidatorCurrentState.success(
          value: password, errors: _errors..[0] = ''));
    }

    // catch re-password
    if (!_isPassword(confirmPassword)) {
      _errors[1] = S.current.MSG09;
      emit(ValidatorCurrentState.failure(errors: _errors));
      return;
    } else {
      // success
      emit(ValidatorCurrentState.success(
          value: password, errors: _errors..[1] = ''));
    }

    // catch compare password and re-password
    if (password != confirmPassword) {
      _errors[1] = S.current.MSG11;
      emit(ValidatorCurrentState.failure(errors: _errors));
      return;
    }

    // success
    emit(ValidatorCurrentState.success(value: password));
  }

  bool _isPassword(String password) {
    return password.length == AppDefaultConstants.appPasswordLength &&
        password.isAllNumeric;
  }
}
