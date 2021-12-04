import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_configuration_module/data/source/local/sessions_pref.dart';
import 'package:flutter_configuration_module/generated/l10n.dart';
import 'package:p2p_borrower/common/constants/loan_app_action_enum.dart';
import 'package:p2p_borrower/common/exceptions/api_exception.dart';
import 'package:p2p_borrower/data/model/request/create_loan_request.dart';
import 'package:p2p_borrower/data/model/response/loan_application_response.dart';
import 'package:p2p_borrower/data/model/response/loan_detail/additional_info_loan_detail_response.dart';
import 'package:p2p_borrower/data/model/response/loan_detail/linked_payment_loan_detail_response.dart';
import 'package:p2p_borrower/data/model/response/loan_detail/loan_application_detail_response.dart';

import 'package:p2p_borrower/data/model/response/loan_master_data_response.dart';
import 'package:p2p_borrower/data/model/response/loan_products_response.dart';
import 'package:p2p_borrower/data/model/response/loan_detail/validate_attribute_loan.dart';
import 'package:p2p_borrower/domain/usecases/create_loan_usecase.dart';
import 'package:p2p_borrower/domain/usecases/update_loan_usecase.dart';
import 'package:p2p_borrower/presentation/journey/loan/create_loan/addition_info_step/cubit/addition_info_step_cubit.dart';
import 'package:p2p_borrower/presentation/journey/loan/create_loan/id_info_step/cubit/id_info_step_cubit.dart';
import 'package:p2p_borrower/presentation/journey/loan/create_loan/loan_info_step/cubit/loan_info_step_cubit.dart';
import 'package:p2p_borrower/presentation/journey/loan/create_loan/occupation_info_step/cubit/occupation_info_cubit.dart';
import 'package:p2p_borrower/presentation/journey/loan/create_loan/occupation_info_step/model/occupation_info_response.dart';
import 'package:p2p_borrower/presentation/journey/loan/create_loan/payment_account_step/cubit/payment_account_step_cubit.dart';
import 'package:p2p_borrower/presentation/journey/loan/create_loan/personal_info_step/cubit/personal_info_step_cubit.dart';
import 'package:p2p_borrower/presentation/journey/loan/create_loan/personal_info_step/model/personal_info_step_response.dart';

import '../../step_create_loan_constants.dart';

part 'create_loan_state.dart';

class CreateLoanCubit extends Cubit<CreateLoanState> {
  final CreateLoanUseCase createLoanUseCase;
  final UpdateLoanUseCase updateLoanUseCase;

  // children cubit
  final LoanInfoStepCubit loanInfoStepCubit;
  final PersonalInfoStepCubit personalInfoStepCubit;
  final OccupationInfoStepCubit occupationInfoStepCubit;
  final PaymentAccountStepCubit paymentAccountStepCubit;
  final IDInfoStepCubit idInfoStepCubit;
  final AdditionInfoStepCubit additionInfoStepCubit;

  CreateLoanCubit(
      {required this.additionInfoStepCubit,
      required this.paymentAccountStepCubit,
      required this.idInfoStepCubit,
      required this.createLoanUseCase,
      required this.loanInfoStepCubit,
      required this.personalInfoStepCubit,
      required this.occupationInfoStepCubit,
      required this.updateLoanUseCase})
      : super(CreateLoanInitial());

  late List<LoanProductsResponse> loanProducts;
  late LoanMasterDataResponse loanMasterDataResponse;
  late LoanProductsResponse loanProductSelected;

  CreateLoanRequest _loanRequest = CreateLoanRequest();

  LoanApplicationResponse? _loanSimpleInit;

  LoanApplicationResponse? get loanSimpleInit => _loanSimpleInit;
  LoanApplicationDetailResponse? _loanDetailInit;

  dynamic _keySimpleLoan;

  dynamic get keySimpleLoan => _keySimpleLoan;

  LoanApplicationResponse? get copyLoanSimpleInit => _loanSimpleInit == null
      ? null
      : LoanApplicationResponse.copy(_loanSimpleInit);

  LoanApplicationDetailResponse? get copyLoanDetailInit =>
      _loanDetailInit == null
          ? null
          : LoanApplicationDetailResponse.copy(_loanDetailInit);

  late bool _isNewLoan;
  bool _isFirst = true;
  late bool _isRemote;

  late LoanAppActionEnum _loanAction;

  LoanAppActionEnum get loanAction => _loanAction;

  Map<String, ValidateAttribute>? _profileValidAttribute;
  Map<String, ValidateAttribute>? _addressValidAttribute;
  Map<String, ValidateAttribute>? _relativeValidAttribute;
  Map<String, ValidateAttribute>? _linkedPaymentValidAttribute;
  List<ValidateAttribute>? _additionalValidAttribute;

  CreateLoanRequest confirmLoanData() {
    _loanRequest.phone = SessionPref.getUserName();
    switch (_loanAction) {
      case LoanAppActionEnum.UPDATE:
        _loanRequest.id = _loanSimpleInit?.id;
        _loanRequest.status = _loanSimpleInit?.status;
        return _loanRequest;
      default:
        return _loanRequest;
    }
  }

  /// set loan info data when finished step
  Future setLoanInfoData(LoanApplicationResponse loanSimpleInit,
      LoanApplicationDetailResponse loanDetailInit) async {
    if (_loanSimpleInit == null) _loanSimpleInit = LoanApplicationResponse();
    if (_loanDetailInit == null)
      _loanDetailInit = LoanApplicationDetailResponse();

    this._loanSimpleInit?.setParams(loanSimpleInit);
    this._loanDetailInit = loanDetailInit;
    _loanRequest.setLoanInfo(_loanDetailInit!.loanProductId!, _loanSimpleInit!,
        icon: _loanSimpleInit?.icon, iconPath: _loanSimpleInit?.iconPath);
    _keySimpleLoan = await _saveData(isNewLoan: _isNewLoan);

    // set loan type to old loan
    if (_isFirst && _isNewLoan) {
      _isNewLoan = false;
      _isFirst = false;
    }
  }

  /// set personal info data when finished step
  Future setPersonalInfoData(PersonalInfoStepModel infoStepModel) async {
    this._loanDetailInit!.setPersonInfo(infoStepModel);
    _loanRequest.setPersonalInfo(_loanDetailInit!);
    await _saveData();
  }

  /// set occupation data when finished step
  Future setOccupationData(
      OccupationInfoStepResponse occupationInfo, bool isStudent) async {
    this._loanDetailInit!.occupation =
        occupationInfo.toOccupationInfoStepRequest(isStudent);
    _loanRequest.occupation =
        occupationInfo.toOccupationInfoStepRequest(isStudent);
    await _saveData();
  }

  /// set linked payment data when finished step
  Future setLinkedPaymentData(
      LinkedPaymentLoanDetailResponse linkedPayment) async {
    this._loanDetailInit!.linkedPayment = linkedPayment;
    _loanRequest.linkedPaymentId = linkedPayment.id;
    await _saveData();

    print(_loanDetailInit!.toJson());
    print(_loanRequest.toJson());
  }

  /// set id images data when finished step
  Future setIDImagesData(String? idCardFront64, String? idCardBack64,
      String? idCardWithUser64) async {
    _loanDetailInit!.setIDImages(idCardFront64, idCardBack64, idCardWithUser64);

    _loanRequest.setIDImages(idCardFront64, idCardBack64, idCardWithUser64);

    await _saveData();
  }

  /// set additional data when finished step
  Future setAdditionalData(
      List<AdditionalInfoLoanDetailResponse> additionalList) async {
    this._loanDetailInit!.additionalInfos = additionalList;
    _loanRequest.setAdditionalInfo(additionalList);

    await _saveData();

    print(_loanRequest.toJson());
  }

  /// update local data
  Future<dynamic> _saveData({bool isNewLoan = false}) async {
    if (!_isRemote && _loanSimpleInit != null && _loanDetailInit != null) {
      return await createLoanUseCase.setALoanInfoToLocal(
          _loanSimpleInit!, _loanDetailInit!, isNewLoan);
    }
  }

  /// initial data method
  /// [loanProductSelected] == null when edit loan
  /// [loanSimple] == null when create new loan
  Future fetchMasterLoanData(
      {List<LoanProductsResponse>? loanProducts,
      LoanProductsResponse? loanProductSelected,
      LoanApplicationResponse? loanSimple,
      LoanAppActionEnum? loanAction,
      bool? isRemote}) async {
    emit(CreateLoanLoading());

    _isNewLoan = loanProductSelected != null && loanSimple == null;

    if (isRemote != null) {
      _isRemote = isRemote;
    }

    if (loanAction != null) {
      _loanAction = loanAction;
    }

    if (loanProducts != null) {
      this.loanProducts = loanProducts;
    }

    if (loanSimple != null) {
      _loanSimpleInit = loanSimple;
    }

    try {
      // fetch master data
      loanMasterDataResponse = (await createLoanUseCase.fetchLoanMasterData())!;

      if (loanProductSelected != null) {
        this.loanProductSelected = loanProductSelected;
      } else if (_loanSimpleInit != null) {
        // fetch loan saved data
        _keySimpleLoan = _loanSimpleInit?.key;
        if (_loanDetailInit == null)
          _loanDetailInit = await createLoanUseCase.getADetailLoan(_isRemote,
              simpleKey: _loanSimpleInit?.key, loanID: _loanSimpleInit?.id);
        // assign product was selected
        this.loanProductSelected = loanProducts!.firstWhere(
            (element) => element.id == _loanDetailInit?.loanProductId);
        // check if update info status or more info required status
        // -> get validate attribute data and assign it to `_validateAttributes`
        // minor valid attribute to maps
        _minorAttributesToMaps();
      }

      // init children cubit
      _initLoanInfoStepCubit();
      _initPersonalInfoStepCubit();
      _initOccupationInfoStepCubit();
      _initPaymentAccountStepCubit();
      _initIDInfoStepCubit();
      _initAdditionInfoStepCubit();

      emit(CreateLoanLoaded(
          loanMasterDataResponse: loanMasterDataResponse,
          loanProductSelected: this.loanProductSelected,
          loanProducts: this.loanProducts));
    } on ApiException catch (apiError) {
      emit(CreateLoanFailure(msg: apiError.errorMessage));
    } catch (e) {
      debugPrint(e.toString());
      emit(CreateLoanFailure(msg: SConfig.current.unKnowError));
    }
  }

  // called when this loan has validate attributes
  // [update info required status] or  [more info required status]
  void _minorAttributesToMaps() {
    _loanDetailInit?.invalidateDatas?.forEach((element) {
      if (element.tableName == StepCreateLoanConstants.PersonalProfileTable) {
        if (_profileValidAttribute == null) _profileValidAttribute = {};
        _profileValidAttribute?[element.attributeName!] = element;
      }

      if (element.tableName == StepCreateLoanConstants.AddressesTable) {
        if (_addressValidAttribute == null) _addressValidAttribute = {};
        _addressValidAttribute?[element.attributeName!] = element;
      }

      if (element.tableName == StepCreateLoanConstants.RelativePersonsTable) {
        if (_relativeValidAttribute == null) _relativeValidAttribute = {};
        _relativeValidAttribute?[element.attributeName!] = element;
      }

      if (element.tableName ==
          StepCreateLoanConstants.MobileLinkedPaymentTable) {
        if (_linkedPaymentValidAttribute == null)
          _linkedPaymentValidAttribute = {};
        _linkedPaymentValidAttribute?[element.attributeName!] = element;
      }

      if (element.tableName == StepCreateLoanConstants.AdditionalInfoTable) {
        if (_additionalValidAttribute == null) _additionalValidAttribute = [];
        _additionalValidAttribute?.add(element);
      }
    });
  }

  void changeLoanProduct(LoanProductsResponse loanProductSelected) {
    this.loanProductSelected = loanProductSelected;

    _initLoanInfoStepCubit();
    _initAdditionInfoStepCubit();

    emit(CreateLoanLoaded(
        loanMasterDataResponse: loanMasterDataResponse,
        loanProductSelected: this.loanProductSelected,
        loanProducts: this.loanProducts));
  }

  void _initLoanInfoStepCubit() {
    loanInfoStepCubit.selectedLoanProduct(this,
        loanMasterDataResponse: this.loanMasterDataResponse,
        loanProductSelected: this.loanProductSelected,
        loanDetailInit: copyLoanDetailInit,
        loanSimpleInit: copyLoanSimpleInit);
  }

  void _initPersonalInfoStepCubit() {
    PersonalInfoStepModel personalInfoLocal = PersonalInfoStepModel.initial();

    if (_loanDetailInit?.profile != null) {
      personalInfoLocal = PersonalInfoStepModel.fromLocalData(
          detailLoan: _loanDetailInit!,
          masterDataResponse: loanMasterDataResponse,
          profileValidAttribute: _profileValidAttribute,
          addressValidAttribute: _addressValidAttribute,
          relativeValidAttribute: _relativeValidAttribute);
    }
    personalInfoStepCubit.initData(
      createLoanCubit: this,
      infoDataResponse: personalInfoLocal,
    );
  }

  void _initOccupationInfoStepCubit() {
    OccupationInfoStepResponse occupationLocalData =
        OccupationInfoStepResponse();

    if (_loanDetailInit?.occupation != null) {
      occupationLocalData = _loanDetailInit!.occupation!
          .toOccupationResponse(loanMasterDataResponse);
      // add valid attributes
      occupationLocalData.profileValidAttribute = _profileValidAttribute;
    }

    occupationInfoStepCubit.initData(
        createLoanCubit: this, occupationDataResponse: occupationLocalData);
  }

  void _initPaymentAccountStepCubit() {
    paymentAccountStepCubit.initData(this,
        linkedPaymentSelected: _loanDetailInit?.linkedPayment);
  }

  void _initIDInfoStepCubit() {
    idInfoStepCubit.initData(this, _loanDetailInit?.idCardWithUserImage,
        _loanDetailInit?.idCardFrontImage, _loanDetailInit?.idCardBackImage,
        profileValidAttribute: _profileValidAttribute);
  }

  void _initAdditionInfoStepCubit() {
    additionInfoStepCubit.initData(this, _loanDetailInit?.additionalInfos,
        loanProductSelected.additionalInfos!,
        additionalValidAttribute: _additionalValidAttribute);
  }
}
