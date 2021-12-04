import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_configuration_module/di/di_module.dart';
import 'package:p2p_borrower/data/model/response/linked_payment_response.dart';
import 'package:p2p_borrower/generated/l10n.dart';
import 'package:p2p_borrower/presentation/common/components/appbars/appbar_step_action.dart';
import 'package:p2p_borrower/presentation/common/components/dialogs/action_dialogs.dart';
import 'package:p2p_borrower/presentation/common/components/dialogs/loading_dialog.dart';
import 'package:p2p_borrower/presentation/journey/linking_payment/cubits/payment_manager_cubit/payment_manager_cubit.dart';

import 'acttion_payment_screen_enum.dart';
import 'linked_payment/linked_payment_empty_widget.dart';
import 'linked_payment/list_linked_payment_widget.dart';

class LinkingPaymentFragment extends StatelessWidget {
  const LinkingPaymentFragment({Key? key, required this.action})
      : super(key: key);

  final ActionPaymentScreenEnum action;

  void _showFailureDialog(BuildContext context, String error) {
    ActionDialogs.showAction(
        context: context,
        message: error,
        rightLabel: S.current.tryAgain,
        callBackRight: () => Navigator.pop(context));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentManagerCubit, PaymentManagerState>(
      listener: (context, state) {
        if (state is PaymentManagerLoaded && state.isLoadingAction) {
          getIt.get<AppLoadingDialog>().showDefault(context);
          return;
        }

        if (state is PaymentManagerLoaded &&
            state.error != null &&
            state.error!.isNotEmpty) {
          getIt.get<AppLoadingDialog>().popDialog(context: context);
          _showFailureDialog(context, state.error!);
          return;
        }

        if (state is PaymentManagerLoaded && state.isSuccess) {
          getIt.get<AppLoadingDialog>().popDialog(context: context);
          return;
        }
      },
      builder: (context, state) {
        if (state is PaymentManagerLoaded) {
          return _buildLayout(context, state.linkedPayments);
        }
        return SizedBox();
      },
    );
  }

  Widget _buildLayout(
      BuildContext context, List<LinkedPaymentResponse> linkedPayments) {
    if (action == ActionPaymentScreenEnum.SELECT) {
      return linkedPayments.isEmpty
          ? LinkedPaymentsEmptyWidget()
          : ListLinkedPaymentWidget(
              linkedPayments: linkedPayments,
              action: action,
            );
    }

    return Scaffold(
      appBar: AppbarAction(
        titleText: S.current.paymentAccount,
      ),
      body: linkedPayments.isEmpty
          ? LinkedPaymentsEmptyWidget()
          : ListLinkedPaymentWidget(
              linkedPayments: linkedPayments,
              action: action,
            ),
    );
  }
}
