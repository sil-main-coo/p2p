import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_configuration_module/generated/l10n.dart';
import 'package:p2p_borrower/common/exceptions/api_exception.dart';
import 'package:p2p_borrower/data/model/response/linked_payment_response.dart';
import 'package:p2p_borrower/domain/usecases/payment_usecase.dart';

part 'payment_manager_state.dart';

/// @Singleton
/// @Global provider
class PaymentManagerCubit extends Cubit<PaymentManagerState> {
  PaymentManagerCubit({required this.paymentUseCase})
      : super(PaymentManagerInitial());

  final PaymentUseCase paymentUseCase;

  List<LinkedPaymentResponse> linkedPayments = [];

  Future fetchLinkedPayment() async {
    emit(PaymentManagerLoading());

    try {
      linkedPayments.clear();
      linkedPayments = (await paymentUseCase.fetchLinkedPayment())!;
      emit(PaymentManagerLoaded(linkedPayments: linkedPayments));
    } on ApiException catch (apiError) {
      emit(PaymentManagerFailure(msg: apiError.errorMessage));
    } catch (e) {
      debugPrint(e.toString());
      emit(PaymentManagerFailure(msg: SConfig.current.unKnowError));
    }
  }

  void addLinkedPayment(LinkedPaymentResponse data) {
    final currentState = state;

    if (currentState is PaymentManagerLoaded) {
      linkedPayments.add(data);
      emit(currentState.copyWith(linkedPayments: linkedPayments));
    }
  }

  void updateLinkedPayment(LinkedPaymentResponse data) {
    final currentState = state;
    if (currentState is PaymentManagerLoaded) {
      final index =
          linkedPayments.indexWhere((element) => element.id == data.id);
      linkedPayments[index] = data;
      emit(currentState.copyWith(linkedPayments: linkedPayments));
    }
  }

  Future removeLinkedPayment(LinkedPaymentResponse data) async {
    final currentState = state;
    if (currentState is PaymentManagerLoaded) {
      emit(currentState.loadingAction());

      try {
        await paymentUseCase.removeLinkedPayment(data.id!);
        linkedPayments.remove(data);

        emit(currentState.successAction(linkedPayments: linkedPayments));
      } on ApiException catch (apiError) {
        emit(currentState.failureAction(apiError.errorMessage));
      } catch (e) {
        debugPrint(e.toString());
        emit(currentState.failureAction(SConfig.current.unKnowError));
      }
    }
  }
}
