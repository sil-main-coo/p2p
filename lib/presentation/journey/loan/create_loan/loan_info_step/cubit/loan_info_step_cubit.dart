import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_configuration_module/data/source/local/sessions_pref.dart';
import 'package:p2p_borrower/data/model/response/loan_application_response.dart';
import 'package:p2p_borrower/data/model/response/loan_detail/loan_application_detail_response.dart';
import 'package:p2p_borrower/data/model/response/loan_master_data_response.dart';
import 'package:p2p_borrower/data/model/response/loan_products_response.dart';
import 'package:p2p_borrower/domain/usecases/create_loan_usecase.dart';
import 'package:p2p_borrower/presentation/journey/loan/create_loan/cubits/create_loan_cubit/create_loan_cubit.dart';

part 'loan_info_step_state.dart';

class LoanInfoStepCubit extends Cubit<LoanInfoStepState> {
  LoanInfoStepCubit({required this.createLoanUseCase})
      : super(LoanInfoStepInitial());

  final CreateLoanUseCase createLoanUseCase;

  bool _isFirst = true; // flag first time initial data

  late LoanMasterDataResponse? _loanMasterDataResponse;

  late CreateLoanCubit _createLoanCubit;

  late LoanApplicationResponse _loanSimpleInit;
  late LoanApplicationDetailResponse _loanDetailInit;
  late LoanProductsResponse _loanProductSelected;

  /// call set and save loan info data
  Future saveData() =>
      _createLoanCubit.setLoanInfoData(_loanSimpleInit, _loanDetailInit);

  void selectedLoanProduct(CreateLoanCubit createLoanCubit,
      {LoanMasterDataResponse? loanMasterDataResponse,
      LoanApplicationResponse? loanSimpleInit,
      LoanApplicationDetailResponse? loanDetailInit,
      required LoanProductsResponse loanProductSelected}) {
    emit(LoanInfoStepInitial());

    this._createLoanCubit = createLoanCubit;
    this._loanProductSelected = loanProductSelected;

    if (_isFirst) {
      if (loanSimpleInit != null && loanDetailInit != null) {
        _loanSimpleInit = loanSimpleInit;
        _loanSimpleInit.amountUnit = _loanProductSelected.amountUnit;

        _loanDetailInit = loanDetailInit;


      } else {
        _loanSimpleInit = LoanApplicationResponse();
        _loanDetailInit = LoanApplicationDetailResponse();

        // map loan product to loan simple and loan detail
        _loanSimpleInit.fromLoanProduct(_loanProductSelected);
        _loanDetailInit.fromLoanProduct(_loanProductSelected);
        // assign phone number
        _loanSimpleInit.phone = SessionPref.getUserName();
      }
      _isFirst = false;
    } else {
      _loanSimpleInit.fromLoanProduct(_loanProductSelected);
      _loanDetailInit.fromLoanProduct(_loanProductSelected);
    }

    if (loanMasterDataResponse != null) {
      this._loanMasterDataResponse = loanMasterDataResponse;
      _loanSimpleInit.interestRate =
          _loanMasterDataResponse!.userCreditRank!.interestRate!;
    }

    _calculatorFees();

    emit(LoanInfoStepLoaded(
        initDuration: _loanSimpleInit.loanDuration,
        initAmount: _loanSimpleInit.loanAmount,
        expectedAmountCharge: _loanSimpleInit.expectedTotalPaymentFormatted,
        serviceCharge: _loanSimpleInit.serviceFeesFormatted));
  }

  void sliderLoanMountChanged(num amount) {
    final currentState = state;
    if (currentState is LoanInfoStepLoaded) {
      _loanSimpleInit.setLoanAmountActualFromEmulatorValue(amount.toInt());

      _calculatorFees();

      emit(LoanInfoStepLoaded(
          expectedAmountCharge: _loanSimpleInit.expectedTotalPaymentFormatted,
          serviceCharge: _loanSimpleInit.serviceFeesFormatted));
    }
  }

  void sliderLoanDurationChanged(num duration) {
    final currentState = state;

    if (currentState is LoanInfoStepLoaded) {
      _loanSimpleInit.loanDuration = duration.toInt();

      _calculatorFees();

      emit(LoanInfoStepLoaded(
          expectedAmountCharge: _loanSimpleInit.expectedTotalPaymentFormatted,
          serviceCharge: _loanSimpleInit.serviceFeesFormatted));
    }
  }

  void _calculatorFees() {
    _loanSimpleInit.setExpectedAmountCharge();
    _loanSimpleInit.setServiceFees();

  }
}
