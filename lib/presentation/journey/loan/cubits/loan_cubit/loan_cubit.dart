import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_configuration_module/generated/l10n.dart';
import 'package:p2p_borrower/common/constants/loan_app_action_enum.dart';
import 'package:p2p_borrower/common/constants/loan_application_status_constants.dart';
import 'package:p2p_borrower/common/exceptions/api_exception.dart';
import 'package:p2p_borrower/data/model/request/loan_status_request.dart';
import 'package:p2p_borrower/data/model/response/loan_application_response.dart';
import 'package:p2p_borrower/domain/usecases/loan_usecase.dart';
import 'package:p2p_borrower/domain/usecases/update_loan_usecase.dart';
import 'package:p2p_borrower/generated/l10n.dart';
import 'package:p2p_borrower/presentation/cubits/loader_cubit/loader_cubit.dart';

part 'loan_state.dart';

class LoanCubit extends Cubit<LoanState> {
  LoanCubit(
      {required this.loanUseCase,
      required this.loaderCubit,
      required this.updateLoanUseCase})
      : super(LoanInitial());

  final LoanUseCase loanUseCase;
  final UpdateLoanUseCase updateLoanUseCase;

  final LoaderCubit loaderCubit;

  late List<LoanApplicationResponse> _loans;

  Future fetchLoanApplications() async {
    emit(LoanLoading());
    try {
      _loans = (await loanUseCase.getLoanApplicationsByBorrower())!;
      emit(LoanLoaded(loanApplications: _loans));
    } on ApiException catch (apiError) {
      emit(LoanFailure(msg: apiError.errorMessage));
    } catch (e) {
      debugPrint(e.toString());
      emit(LoanFailure(msg: SConfig.current.unKnowError));
    }
  }

  Future removeLoanApplication(LoanApplicationResponse loanItem) async {
    final currentState = state;
    if (currentState is LoanLoaded) {
      loaderCubit.loading();
      try {
        await loanUseCase.removeLoan(false, loanItem);
        _loans.remove(loanItem);

        loaderCubit.success(messages: [S.current.cancelLoanSuccessMsg]);
        emit(currentState.copyWith(
            loanApplications: _loans, actionEnum: LoanAppActionEnum.REMOVE));
      } on ApiException catch (apiError) {
        loaderCubit.failure(messages: [apiError.errorMessage]);
      } catch (e) {
        debugPrint(e.toString());
        loaderCubit.failure(messages: [SConfig.current.unKnowError]);
      }
    }
  }

  /// input: loan item data
  /// output: loan cubit state include new loan data and `CONFIRM_INTEREST_RATE` action
  /// in presentation layout, need listen `CONFIRM_INTEREST_RATE` in loaded state
  /// to handling
  Future confirmInterestRateLoan(LoanApplicationResponse loanItem) async {
    final currentState = state;
    if (currentState is LoanLoaded) {
      loaderCubit.loading();

      try {
        await Future.delayed(Duration(seconds: 3));
        loanItem.status = LoanApplicationStatus.OnMarket;
        loanItem.statusDisplay = null;
        final index = _loans.indexWhere((element) => element.id == loanItem.id);
        if (index >= 0) {
          _loans[index] = loanItem;
        } else {
          _loans.insert(0, loanItem);
        }
        emit(currentState.copyWith(
            loanApplications: _loans,
            actionEnum: LoanAppActionEnum.CONFIRM_INTEREST_RATE));
      } on ApiException catch (apiError) {
        loaderCubit.failure(messages: [apiError.errorMessage]);
      } catch (e) {
        debugPrint(e.toString());
        loaderCubit.failure(messages: [SConfig.current.unKnowError]);
      }
    }
  }

  /// input: loan item data
  /// output: loan cubit state include new loan data and `SIGN_CONTRACT` action
  /// in presentation layout, need listen `SIGN_CONTRACT` in loaded state
  /// to handling
  Future signLoanContract(LoanApplicationResponse loanItem) async {
    final currentState = state;
    if (currentState is LoanLoaded) {
      loaderCubit.loading();

      try {
        final response = await updateLoanUseCase.signLoanContract(
            LoanStatusRequest(
                id: loanItem.id,
                status: LoanApplicationStatus.DisburmentPending));
        if (response != null && response.isSuccess!) {
          loanItem.status = LoanApplicationStatus.DisburmentPending;
          updateALoanInListByID(loanItem,
              action: LoanAppActionEnum.SIGN_CONTRACT);
        } else {
          loaderCubit.failure(messages: [SConfig.current.unKnowError]);
        }
      } on ApiException catch (apiError) {
        loaderCubit.failure(messages: [apiError.errorMessage]);
      } catch (e) {
        debugPrint(e.toString());
        loaderCubit.failure(messages: [SConfig.current.unKnowError]);
      }
    }
  }

  void addALoanToList(LoanApplicationResponse? newLoan) {
    final currentState = state;
    if (currentState is LoanLoaded && newLoan != null) {
      loaderCubit.loading();
      _loans.insert(0, newLoan);
      loaderCubit.loaded();
      emit(currentState.copyWith(loanApplications: _loans));
    }
  }

  void removeALocalLoanInListByKey(key) {
    final currentState = state;
    if (currentState is LoanLoaded && key != null) {
      loaderCubit.loading();
      _loans.removeWhere((element) => element.key == key);
      loaderCubit.loaded();
      emit(currentState.copyWith(loanApplications: _loans));
    }
  }

  void updateALoanInListByID(LoanApplicationResponse? newLoan,
      {LoanAppActionEnum? action}) {
    final currentState = state;
    if (currentState is LoanLoaded && newLoan != null) {
      loaderCubit.loading();
      final index = _loans.indexWhere((element) => element.id == newLoan.id);
      if (index >= 0) {
        _loans[index] = newLoan;
      } else {
        _loans.insert(0, newLoan);
      }
      loaderCubit.loaded();
      emit(currentState.copyWith(loanApplications: _loans, actionEnum: action));
    }
  }

  void updateALoanInListByKey(LoanApplicationResponse? newLoan) {
    final currentState = state;
    if (currentState is LoanLoaded && newLoan != null) {
      loaderCubit.loading();
      final index = _loans.indexWhere((element) => element.key == newLoan.key);
      if (index >= 0) {
        _loans[index] = newLoan;
      } else {
        _loans.insert(0, newLoan);
      }
      loaderCubit.loaded();
      emit(currentState.copyWith(loanApplications: _loans));
    }
  }
}
