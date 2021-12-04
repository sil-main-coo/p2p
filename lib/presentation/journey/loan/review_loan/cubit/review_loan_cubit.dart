import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_configuration_module/generated/l10n.dart';
import 'package:p2p_borrower/common/constants/loan_app_action_enum.dart';
import 'package:p2p_borrower/common/exceptions/api_exception.dart';
import 'package:p2p_borrower/data/model/request/create_loan_request.dart';
import 'package:p2p_borrower/data/model/response/create_loan_response.dart';
import 'package:p2p_borrower/domain/usecases/create_loan_usecase.dart';
import 'package:p2p_borrower/domain/usecases/update_loan_usecase.dart';
import 'package:p2p_borrower/presentation/journey/loan/cubits/loan_cubit/loan_cubit.dart';

part 'review_loan_state.dart';

class ReviewLoanCubit extends Cubit<ReviewLoanState> {
  ReviewLoanCubit(
      {required this.createLoanUseCase, required this.updateLoanUseCase})
      : super(ReviewLoanInitial());

  final CreateLoanUseCase createLoanUseCase;
  final UpdateLoanUseCase updateLoanUseCase;

  late LoanCubit _loanCubit;

  dynamic
      _hiveKeyLoanSimple; // key of simple loan in hive box -> remove local data when create loan success

  void initData(dynamic hiveKeyLoanSimple, LoanCubit loanCubit) {
    _hiveKeyLoanSimple = hiveKeyLoanSimple;
    _loanCubit = loanCubit;
  }

  Future sendLoanProfile(
      {required CreateLoanRequest request,
      required LoanAppActionEnum loanAction}) async {
    emit(ReviewLoanLoading());

    try {
      CreateLoanResponse? response;

      if (loanAction == LoanAppActionEnum.UPDATE) {
        // update a loan
        response = await updateLoanUseCase.updateLoan(request);
        if (response != null) {
          // updated
          response.data?.setIcon(request.icon, request.iconPath);
          _loanCubit.updateALoanInListByID(response.data);
        }
      } else {
        // create a loan
        response =
            await createLoanUseCase.createLoan(_hiveKeyLoanSimple, request);
        if (response != null && _hiveKeyLoanSimple != null) {
          // created
          _loanCubit.removeALocalLoanInListByKey(_hiveKeyLoanSimple);
          // set icon because response create loan has not icons
          response.data?.setIcon(request.icon, request.iconPath);
          _loanCubit.addALoanToList(response.data);
        }
      }

      if (response != null) {
        emit(ReviewLoanSuccess());
        return;
      }

      emit(ReviewLoanFailure(msg: SConfig.current.unKnowError));
    } on ApiException catch (apiError) {
      emit(ReviewLoanFailure(msg: apiError.errorMessage));
    } catch (e) {
      debugPrint(e.toString());
      emit(ReviewLoanFailure(msg: SConfig.current.unKnowError));
    }
  }
}
