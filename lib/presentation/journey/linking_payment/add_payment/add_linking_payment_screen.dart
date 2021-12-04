import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_configuration_module/di/di_module.dart';
import 'package:p2p_borrower/common/constants/type_payment_enum.dart';
import 'package:p2p_borrower/data/model/response/linked_payment_response.dart';
import 'package:p2p_borrower/generated/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:p2p_borrower/presentation/common/components/appbars/appbar_step_action.dart';
import 'package:p2p_borrower/presentation/common/components/dialogs/action_dialogs.dart';
import 'package:p2p_borrower/presentation/common/components/dialogs/loading_dialog.dart';
import 'package:p2p_borrower/presentation/common/components/failures/normal_failure_widget.dart';
import 'package:p2p_borrower/presentation/common/components/layout/compact_layout.dart';
import 'package:p2p_borrower/presentation/common/components/space_widgets/vertical_space_widget.dart';
import 'package:p2p_borrower/presentation/journey/linking_payment/cubits/linking_payment_cubit/linking_payment_cubit.dart';

import 'widgets/form_linking_payment_widget.dart';
import 'widgets/type_payment_select_widget.dart';

class AddLinkingPaymentScreen extends StatelessWidget {
  AddLinkingPaymentScreen({Key? key}) : super(key: key);

  final ctrlBankService = TextEditingController();
  final ctrlVirtualWalletService = TextEditingController();

  Future _addLinkingPayment(BuildContext context) async {
    await BlocProvider.of<LinkingPaymentCubit>(context).saveLinkingPayment();
  }

  void _addDone(BuildContext context, LinkedPaymentResponse linkedPayment) {
    Navigator.pop<LinkedPaymentResponse?>(context, linkedPayment);
  }

  void _cancelAdd(BuildContext context) {
    Navigator.pop(context, false);
  }

  void _showFailureDialog(BuildContext context, String error) {
    ActionDialogs.showAction(
        context: context,
        message: error,
        rightLabel: S.current.tryAgain,
        callBackRight: () => Navigator.pop(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<LinkingPaymentCubit, LinkingPaymentState>(
      listener: (context, state) {
        if (state is LinkingPaymentLoaded) {
          if (state.isLoadingAction) {
            getIt.get<AppLoadingDialog>().showDefault(context);
            return;
          }

          if (state.isSuccessAction) {
            getIt.get<AppLoadingDialog>().popDialog(context: context);
            _addDone(context, state.linkedPayment!);
            return;
          }

          if (state.errorAction != null) {
            getIt.get<AppLoadingDialog>().popDialog(context: context);
            _showFailureDialog(context, state.errorAction!);
            return;
          }
        }
      },
      builder: (context, state) {
        if (state is LinkingPaymentLoaded) {
          return _loadedWidget(context, state);
        }
        if (state is LinkingPaymentFailure) {
          return _failureWidget(context, state);
        }

        return _loadingWidget();
      },
    ));
  }

  Widget _failureWidget(BuildContext context, LinkingPaymentFailure state) {
    return NormalFailureWidget(
      message: state.msg,
      label: S.current.tryAgain,
      label1: S.current.goBack,
      onPressed1: () => Navigator.pop(context),
      onPressed: () =>
          BlocProvider.of<LinkingPaymentCubit>(context)..fetchData(),
    );
  }

  Widget _loadingWidget() {
    return Center(child: const CircularProgressIndicator());
  }

  Widget _loadedWidget(BuildContext context, LinkingPaymentLoaded state) {
    return Scaffold(
      appBar: AppbarAction(
        automaticallyImplyLeading: false,
        leadingWidget: IconButton(
          onPressed: () => _cancelAdd(context),
          icon: Icon(
            Icons.close,
            size: 26.w,
          ),
        ),
        titleText: S.current.addAccount,
        textAction: state.isValid ? S.current.add : null,
        callbackAction:
            state.isValid ? () => _addLinkingPayment(context) : null,
      ),
      body: CompactLayout(
          child: Column(
        children: [
          TypePaymentSelectWidget(state.indexTab),
          VerticalSpace.init32(),
          _formWidget(state)
        ],
      )),
    );
  }

  Widget _formWidget(LinkingPaymentLoaded loadedState) {
    return Visibility(
        visible: loadedState.indexTab != null,
        child: IndexedStack(
          index: loadedState.indexTab,
          children: [
            FormLinkingPaymentWidget(
              ctrlPaymentService: ctrlBankService,
              typePayment: TypePaymentEnum.Bank,
              services: loadedState.bankServices,
              serviceSelected: loadedState.bankSelected,
            ),
            FormLinkingPaymentWidget(
              ctrlPaymentService: ctrlVirtualWalletService,
              typePayment: TypePaymentEnum.VirtualWallet,
              services: loadedState.virtualWalletServices,
              serviceSelected: loadedState.walletSelected,
            ),
          ],
        ));
  }
}
