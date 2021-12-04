import 'package:flutter/material.dart';
import 'package:p2p_borrower/generated/l10n.dart';
import 'package:p2p_borrower/presentation/common/components/layout/green_alert_layout.dart';
import 'package:p2p_borrower/presentation/common/loan_utils/loan_push_to_action_utils.dart';
import 'package:p2p_borrower/presentation/journey/home/home_route.dart';

class SignContractSuccessScreen extends StatelessWidget {
  const SignContractSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GreenAlertLayout(
      title: S.current.signContractSuccess,
      msg: S.current.signContractSuccessMsg,
      btnLabel1: S.current.backHome,
      onPressed1: () =>
          Navigator.popUntil(context, ModalRoute.withName(HomeRoute.id)),
      btnLabel2: S.current.reviewContract,
      onPressed2: () => LoanPushToActionUtils()..pushToContract(context, true),
    );
  }
}
