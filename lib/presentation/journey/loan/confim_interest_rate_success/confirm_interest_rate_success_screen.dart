import 'package:flutter/material.dart';
import 'package:p2p_borrower/generated/l10n.dart';
import 'package:p2p_borrower/presentation/common/components/layout/green_alert_layout.dart';
import 'package:p2p_borrower/presentation/journey/home/home_route.dart';

class ConfirmInterestRateSuccessScreen extends StatelessWidget {
  const ConfirmInterestRateSuccessScreen({Key? key}) : super(key: key);

  void _backHome(BuildContext context) {
    Navigator.popUntil(context, ModalRoute.withName(HomeRoute.id));
  }

  @override
  Widget build(BuildContext context) {
    return GreenAlertLayout(
      title: S.current.confirmInterestRateSuccess,
      msg: S.current.confirmInterestRateSuccessMsg,
      btnLabel1:
          '${S.current.ok.toUpperCase()}, ${S.current.backHome.toLowerCase()}',
      onPressed1: () => _backHome(context),
    );
  }
}
