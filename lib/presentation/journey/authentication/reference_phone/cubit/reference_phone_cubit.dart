import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_configuration_module/generated/l10n.dart';
import 'package:p2p_borrower/common/exceptions/api_exception.dart';
import 'package:p2p_borrower/common/exceptions/local_exception.dart';
import 'package:p2p_borrower/data/model/request/reference_phone_request.dart';
import 'package:p2p_borrower/data/model/response/reference_phone_response.dart';
import 'package:p2p_borrower/domain/usecases/authentication_usecase.dart';

part 'reference_phone_state.dart';

class ReferencePhoneCubit extends Cubit<ReferencePhoneState> {
  ReferencePhoneCubit({
    required this.authenticationUseCase,
  }) : super(ReferencePhoneInitial());

  final AuthenticationUseCase authenticationUseCase;

  Future referencePhone(ReferencePhoneRequest request) async {
    emit(ReferencePhoneLoading());

    try {
      final response = await authenticationUseCase.addReferencePhone(request);
      if (response!.isSuccess!) {
        emit(ReferencePhoneSuccess(response: response));
      } else {
        emit(ReferencePhoneFailure(
            msg: response.message ?? SConfig.current.unKnowError));
      }
    } on ApiException catch (apiError) {
      emit(ReferencePhoneFailure(msg: apiError.errorMessage));
    } on LocalException catch (localError) {
      emit(ReferencePhoneFailure(
          msg: localError.message ?? SConfig.current.deviceError));
    } catch (e) {
      emit(ReferencePhoneFailure(msg: SConfig.current.unKnowError));
    }
  }
}
