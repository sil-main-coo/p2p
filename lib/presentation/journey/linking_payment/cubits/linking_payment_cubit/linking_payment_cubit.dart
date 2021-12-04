import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_configuration_module/generated/l10n.dart';
import 'package:flutter_configuration_module/utility/extentions/string_extension.dart';

import 'package:p2p_borrower/common/constants/type_payment_enum.dart';
import 'package:p2p_borrower/common/exceptions/api_exception.dart';
import 'package:p2p_borrower/data/model/request/linking_payment_request.dart';
import 'package:p2p_borrower/data/model/response/linked_payment_response.dart';
import 'package:p2p_borrower/data/model/response/payment_services_response.dart';
import 'package:p2p_borrower/domain/usecases/payment_usecase.dart';

part 'linking_payment_state.dart';

class LinkingPaymentCubit extends Cubit<LinkingPaymentState> {
  final PaymentUseCase selectPaymentUseCase;

  LinkingPaymentCubit({required this.selectPaymentUseCase})
      : super(LinkingPaymentInitial());

  late List<PaymentServiceResponse> bankServices;
  late List<PaymentServiceResponse> virtualWalletServices;
  PaymentServiceResponse? bankSelected;
  PaymentServiceResponse? walletSelected;

  int? _indexTab;

  LinkingPaymentRequest _linkingPaymentRequest = LinkingPaymentRequest();

  Future fetchData() async {
    try {
      final paymentServices = await selectPaymentUseCase.fetchPaymentServices();
      if (paymentServices != null && paymentServices.isNotEmpty) {
        bankServices = paymentServices
            .where((element) =>
                element.type == TypePaymentEnum.Bank.toString().enumToName)
            .toList();
        virtualWalletServices = paymentServices
            .where((element) =>
                element.type ==
                TypePaymentEnum.VirtualWallet.toString().enumToName)
            .toList();
        emit(LinkingPaymentLoaded(
            bankServices: bankServices,
            isValid: false,
            virtualWalletServices: virtualWalletServices));
      }
    } on ApiException catch (apiError) {
      emit(LinkingPaymentFailure(msg: apiError.errorMessage));
    } catch (e) {
      debugPrint(e.toString());
      emit(LinkingPaymentFailure(msg: SConfig.current.unKnowError));
    }
  }

  Future saveLinkingPayment() async {
    final currentState = state;

    if (currentState is LinkingPaymentLoaded) {
      emit(currentState.loading());

      try {
        final linkedPayment = await selectPaymentUseCase
            .addOrUpdateLinkedPayment(request: _linkingPaymentRequest);
        emit(currentState.successAction(linkedPayment: linkedPayment!));
      } on ApiException catch (apiError) {
        emit(currentState.failureAction(apiError.errorMessage));
      } catch (e) {
        debugPrint(e.toString());
        emit(currentState.failureAction(SConfig.current.unKnowError));
      }
    }
  }

  void tabChanged(int index) {
    _indexTab = index;
    if (state is LinkingPaymentLoaded) {
      emit((state as LinkingPaymentLoaded)
          .copyWith(indexTab: _indexTab, isValid: _isValid()));
    }
  }

  void paymentChanged(
      PaymentServiceResponse data, TypePaymentEnum typePayment) {
    if (state is LinkingPaymentLoaded) {
      _linkingPaymentRequest.serviceId = data.id;
      switch (typePayment) {
        case TypePaymentEnum.Bank:
          bankSelected = data;
          emit((state as LinkingPaymentLoaded)
              .copyWith(bankSelected: bankSelected, isValid: this._isValid()));
          break;
        case TypePaymentEnum.VirtualWallet:
          walletSelected = data;
          emit((state as LinkingPaymentLoaded).copyWith(
              walletSelected: walletSelected, isValid: this._isValid()));
          break;
      }
    }
  }

  void fullNameChanged(String value) {
    if (state is LinkingPaymentLoaded) {
      _linkingPaymentRequest.serviceAccountName = value;
      emit((state as LinkingPaymentLoaded).copyWith(isValid: this._isValid()));
    }
  }

  void numberAccountChanged(String value, TypePaymentEnum typePayment) {
    if (state is LinkingPaymentLoaded) {
      switch (typePayment) {
        case TypePaymentEnum.Bank:
          _linkingPaymentRequest.serviceAccountId = value;
          break;
        case TypePaymentEnum.VirtualWallet:
          _linkingPaymentRequest.phone = value;
          break;
      }

      emit((state as LinkingPaymentLoaded).copyWith(isValid: this._isValid()));
    }
  }

  bool _isValid() {
    if (_linkingPaymentRequest.serviceAccountName == null ||
        _linkingPaymentRequest.serviceAccountName!.isEmpty) return false;

    if (_indexTab == 0 &&
        (bankSelected == null ||
            _linkingPaymentRequest.serviceAccountId == null ||
            _linkingPaymentRequest.serviceAccountId!.isEmpty ||
            _linkingPaymentRequest.serviceAccountId!.length < 5 ||
            _linkingPaymentRequest.serviceAccountId!.length > 20)) return false;

    if (_indexTab == 1 &&
        (walletSelected == null ||
            _linkingPaymentRequest.phone == null ||
            _linkingPaymentRequest.phone!.isEmpty ||
            _linkingPaymentRequest.phone!.length < 5 ||
            _linkingPaymentRequest.phone!.length > 20)) return false;
    return true;
  }
}
