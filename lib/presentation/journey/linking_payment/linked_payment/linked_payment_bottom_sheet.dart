import 'package:flutter/material.dart';
import 'package:p2p_borrower/data/model/response/linked_payment_response.dart';

import 'package:p2p_borrower/generated/l10n.dart';
import 'package:p2p_borrower/presentation/common/components/bottom_sheets/bottom_sheet_default/content_bottom_sheet_default.dart';
import 'package:p2p_borrower/presentation/common/styles/style.dart';
import 'package:p2p_borrower/presentation/journey/linking_payment/cubits/payment_manager_cubit/payment_manager_cubit.dart';

class LinkedPaymentBottomSheet {
  static void show(
      {required BuildContext context,
      required PaymentManagerCubit paymentManagerCubit,
      required LinkedPaymentResponse payment}) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) => LinkedPaymentBottomSheetWidget(
        paymentManagerCubit: paymentManagerCubit,
        payment: payment,
      ),
    );
  }
}

class LinkedPaymentBottomSheetWidget extends StatelessWidget {
  LinkedPaymentBottomSheetWidget(
      {Key? key, required this.paymentManagerCubit, required this.payment})
      : super(key: key);

  final PaymentManagerCubit paymentManagerCubit;
  final LinkedPaymentResponse payment;

  @override
  Widget build(BuildContext context) {
    final buttons = [
      ButtonBottomSheetModel(
          label: '${S.current.editAccountInfo}',
          color: Colors.black,
          onPressed: () async {
            Navigator.pop(context);
          }),
      ButtonBottomSheetModel(
        label: '${S.current.removeAccount}',
        color: mColorBad,
        onPressed: () async {
          await paymentManagerCubit.removeLinkedPayment(payment);
          Navigator.pop(context);
        },
      )
    ];

    return ContentBottomSheetDefault(
      title: S.current.option,
      buttons: buttons,
    );
  }
}
